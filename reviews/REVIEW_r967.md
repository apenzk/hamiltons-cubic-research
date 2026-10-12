# r967, Gate 2 on I106a's piece 2: the frame variation's first and second order

Reviewer **r967**, single reviewer by design: this round compares a variation against text already fixed on the record rather than checking reasoning being made. Every finding below states how far it reaches, and nothing proved about the frame direction is generalised into a claim about the layer it sits in.

Log: [agent_logs/r967-fencing.log](../agent_logs/r967-fencing.log)

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | Varying $P$ alone gives tangent $\dot{\hat U}=0$, $\dot V=[\Omega,V]$, and that curve stays on the constraint surface | **CONFIRMED**, with the degenerate-$V$ scope below |
| 2 | The frame-dependent part of the value is $\beta\operatorname{tr}(\hat UV^2)+\operatorname{tr}(VC)$ | **CONFIRMED** against the record's own $\Phi$ |
| 3 | Its variation is $\operatorname{tr}\big([\Omega,V](\beta\{\hat U,V\}+C)\big)$, so stationarity for every skew $\Omega$ is $[V,\beta\{\hat U,V\}+C]=0$ | **CONFIRMED**, one unstated hypothesis named |
| 4 | Substituting $C$'s own form makes that bracket vanish for every $\hat U$, $V$, $\mu$, $\beta$ | **CONFIRMED**, exact |
| 5 | With a GENERIC symmetric field in place of $C$ the same bracket does NOT vanish | **CONFIRMED** as a fact, **the control is weak** |
| 6 | Batch 21's condition at $(X,Y)=(0,[\Omega,V])$ reproduces the frame second variation exactly | **CONFIRMED**, exact, no factor and no missing term |
| 7 | The quoted batch 22 sentence covers the direction of claim 6 | **REFUTED** |
| 8 | Nothing else on the record already states claim 3 or claim 4 under another name | **REFUTED** |

## Claim 1: the tangent and the curve

**CONFIRMED.** The curve is $V(t)=e^{t\Omega}Ve^{-t\Omega}$ with $\hat U$ and $C$ held, so $\dot V=[\Omega,V]$ and $\dot{\hat U}=0$. The tangent is traceless symmetric: $[\Omega,V]^{\mathsf T}=V^{\mathsf T}\Omega^{\mathsf T}-\Omega^{\mathsf T}V^{\mathsf T}=[\Omega,V]$ needs $V$ symmetric and $\Omega$ skew, and the trace of a commutator vanishes.

The constraint is the single quadratic $T=\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$, as [constraint_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) fixes it. Conjugation by an orthogonal matrix preserves $\lvert V\rvert$ and $\hat U$ is fixed, so the **whole curve** lies on the surface, not merely to first order. Screened: $\lvert V(0.7)\rvert-\lvert V\rvert=0$ to machine zero.

**Scope.** The frame family $\{[\Omega,V]:\Omega\text{ skew}\}$ is three-dimensional only where $V$ has simple spectrum. At a repeated eigenvalue the stabiliser grows and the family drops to two dimensions, and the claim is silent about that stratum. This does not affect claims 3 to 6, which hold for whatever $\Omega$ the family supplies.

## Claim 2: which part of the value moves

**CONFIRMED**, and the reading matters. The record's value is $\Phi=\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)+\operatorname{tr}(\hat UA)+\operatorname{tr}(VC)$ with $A$ and $C$ **given external data** diagonal in a frame $F$ ([batch 5](2026-09-15-I106-m3-derivation.md), [L229](../results.md)). Under the frame curve $\alpha\operatorname{tr}\hat U^3$ and $\operatorname{tr}(\hat UA)$ are fixed because $\hat U$ is, and $T$ is fixed by claim 1, so exactly $\beta\operatorname{tr}(\hat UV^2)+\operatorname{tr}(VC)$ moves.

**The distinction worth keeping.** Had $\Phi$ meant the cubic part alone, the frame-dependent part would be $\beta\operatorname{tr}(\hat UV^2)$ and claim 6 would be false, as the screen below shows. The claim is right because the record's $\Phi$ carries the field pairings, and because $A$ and $C$ are data rather than multipliers to be re-solved along the curve.

## Claim 3: the variation, and the one hypothesis that is doing work

**CONFIRMED.** Symbolically exact over generic traceless symmetric $\hat U$, $V$ and generic skew $\Omega$, residual $0$ in both steps:

$$\beta\operatorname{tr}\big(\hat U(\dot VV+V\dot V)\big)+\operatorname{tr}(\dot VC)=\operatorname{tr}\big(\dot V(\beta\{\hat U,V\}+C)\big),\qquad \operatorname{tr}\big([\Omega,V]M\big)=\operatorname{tr}\big(\Omega[V,M]\big).$$

**The trace step needs no symmetry of $\hat U$.** The brief asks whether $\operatorname{tr}(\hat UV^2)$'s variation really contributes $\{\hat U,V\}$ and whether symmetry is smuggled in. It does, by cyclicity alone: repeating the step with a fully generic nonsymmetric $\hat U$ leaves residual $0$. So that half is a ring identity.

**Symmetry is load-bearing one step later, and the block does not say so.** Passing from $\operatorname{tr}(\Omega[V,M])=0$ for every skew $\Omega$ to $[V,M]=0$ needs $[V,M]$ to be skew, since the skew matrices annihilate exactly the symmetric ones under the trace form. With $V$ and $M=\beta\{\hat U,V\}+C$ both symmetric, $[V,M]^{\mathsf T}=-[V,M]$ and the conclusion follows. Verified: $[V,M]+[V,M]^{\mathsf T}=0$ identically with a symmetric field, and **not** identically zero with a nonsymmetric one. Were $C$ allowed to be nonsymmetric, stationarity would give only the weaker $\operatorname{skew}[V,M]=0$. Symmetry of $C$ is in the setting, so the block's conclusion stands, and the step should be named rather than left silent.

## Claim 4: the substituted bracket

**CONFIRMED**, exactly. With $C=\mu V-\beta\{\hat U,V\}+cI$ carried with its undetermined multiple of $I$ throughout, $[V,\beta\{\hat U,V\}+C]$ is the zero matrix symbolically, and $9.6\cdot10^{-17}$ numerically. The multiple of $I$ is harmless because $[V,I]=0$, which is [I_multiple_drops](../lean/HamiltonsCubic/Results/I106Criticality.lean) already on the record.

**What it would take for this to be uninformative, as the brief asks.** Two readings, and they separate.

- **As a polynomial statement it is not vacuous.** The expression is not identically zero before substitution, which is claim 5.
- **As mathematics it carries no information beyond criticality itself.** The bracket is $[V,\nabla_V\Phi]$, and the $V$ equation says $\nabla_V\Phi=\mu V$ modulo $I$, that is, the gradient is parallel to the constraint gradient. The vanishing is then $[V,\mu V]=0$. No feature of the cubic enters, and the same collapse would occur for any objective whatever whose $V$ gradient is parallel to $V$ at the point. The fence is real and the direction is genuinely closed, and the reason is that a first-order condition at a critical point is criticality read along one direction.

## Claim 5: the control

**CONFIRMED as a fact.** With a generic traceless symmetric $C_g$ the bracket is not the zero matrix symbolically, and reaches $2.01$ against the substituted form's $9.6\cdot10^{-17}$ on the same triple. A fully generic nonsymmetric field reaches $2.97$. These are screens, reported as screens.

**A closed form the record should prefer to the screen.** The non-vanishing has an exact hypothesis-free expression, confirmed symbolically at residual $0$:

$$[V,\ \beta\{\hat U,V\}+C]\ =\ \beta\,[V^2,\hat U]\ +\ [V,C].$$

At $C=0$ this is $\beta[V^2,\hat U]$, nonzero whenever $\hat U$ fails to commute with $V^2$. That supplies exactly the explicit witness the brief's Lean row 5 records as missing, so the row can be improved rather than left as "none": the identity above closes by `noncomm_ring` with no symmetry and no tracelessness, and the non-vanishing then reduces to one numeric pair.

**The control is adequate but weak, and the post's language overstates what it buys.** The fence post reads the contrast as separating "a collapse caused by the substitution from one caused by the geometry". It does not separate those. Replacing $C$ by a field that fails the $V$ equation makes the point non-critical, and at a non-critical point the first variation of a non-constant functional has no reason to vanish in any direction at all. So the contrast confirms that the expression is non-trivial and nothing more. A control that would separate the two would hold criticality and vary the direction, which is what claim 6 does.

## Claim 6: the second order

**CONFIRMED**, exactly, with no factor and no missing term. Symbolic residual $0$ for

$$\ddot\Phi(0)\ =\ 2\beta\operatorname{tr}(\hat UY^2)-\mu\lvert Y\rvert^2,\qquad Y=[\Omega,V],$$

which is batch 21's left side minus its right side at $(X,Y)=(0,[\Omega,V])$. Numerically $0.52801314$ against $0.52801315$.

**Tangency holds identically.** Batch 21 quantifies over $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)=0$, and at $X=0$ that is $\operatorname{tr}(V[\Omega,V])=\operatorname{tr}(\Omega[V,V])=0$ for every $\Omega$. So the specialisation is legitimate for the whole three-dimensional frame family, with no side condition.

**Two inputs the word "reproduces" hides, and both are sound.** The curve is not a straight line, so its acceleration $\ddot V=[\Omega,[\Omega,V]]$ contributes through the first-order gradient. That contribution is turned into the right side by the $V$ equation together with $\operatorname{tr}(\ddot VV)=-\lvert Y\rvert^2$, which is isospectrality differentiated twice, residual $0$. So claim 6 consumes the first-order system and is not a bare identity. Batch 21's own stated premise, that at a critical point the second derivative along **any** curve on the constraint surface is $D^2(\Phi-\mu T)$ on the tangent alone, gives the same result in one line and is the cleaner route.

**The term that must not be dropped.** Computing the second variation of the cubic part alone, without $\operatorname{tr}(VC)$, gives a different number: $-0.4466$ against $0.5280$, a miss of $-0.9747$, and the gap is exactly $-\operatorname{tr}(C\ddot V)$, confirmed symbolically at residual $0$. Claim 6 is true for the record's $\Phi$ and false for the cubic part alone, which is the same point claim 2 turns on.

## Claim 7: what batch 22's sentence reaches

**REFUTED.** Batch 22's quadratic $at^2+bt+c$ is built from the line $(Z,tZ)$, which is tangent for **every** $t$ only when $\operatorname{tr}(\hat UZ)=\operatorname{tr}(VZ)=0$. Its coefficients, including $a=2\beta\operatorname{tr}(\hat UZ^2)-\mu\lvert Z\rvert^2$, are therefore defined only for $Z$ in the three-dimensional subspace $W=\{Z:\operatorname{tr}(\hat UZ)=\operatorname{tr}(VZ)=0\}$.

The frame directions meet one of those two conditions and not the other. Symbolically, at residual $0$,

$$\operatorname{tr}(V[\Omega,V])=0\ \text{ for every }\Omega,\qquad \operatorname{tr}(\hat U[\Omega,V])=-\operatorname{tr}(\Omega K),\quad K=[\hat U,V].$$

So $[\Omega,V]\in W$ if and only if $\Omega$ is orthogonal to $K$ in the trace form. **On the non-commuting stratum that is a two-dimensional slice of the three-dimensional family**, and batch 22's $a$ says nothing about the missing direction. The one place where it covers the whole family is $K=0$, which is the stratum the programme is trying to reach rather than one it may assume.

**The conclusion survives, the citation does not.** Batch 21 at $X=0$ needs only $\operatorname{tr}(VY)=0$, which every frame direction satisfies identically, so the direction genuinely is already extracted. The repair is to cite batch 21's $X=0$ specialisation directly, together with batch 21's own closing line that such specialisations are "all that has been extracted from it so far", and to drop the appeal to batch 22.

**How far this reaches.** This is a finding about one citation of batch 22 in one block about one direction. Batch 22's inequality is untouched, its subspace $W$ is correctly described where it is stated, and nothing here bears on other appeals to it.

## Claim 8: whether the record already held this

**REFUTED**, and the thing that predates it is the general principle rather than the bracket.

Batch 21 states, as the standing justification for its own condition: *"At a critical point the first differential of $\Phi-\mu T$ vanishes, so along any curve on the constraint surface the second derivative is $D^2(\Phi-\mu T)$ applied to the tangent vector alone, with no contribution from the curve's acceleration."* The frame curve is a curve on the constraint surface, by claim 1. So the vanishing of its first order is an instance of a sentence already fixed on the record before this block opened, and claim 4 is that sentence read along one direction.

**What I searched, by the object rather than by vocabulary.** The bracket $[V,\beta\{\hat U,V\}+C]$ and the anticommutator form $\beta\{\hat U,V\}+C$ across [findings/](../findings/), [results.md](../results.md), [routes.md](../routes.md), [plan.md](../plan.md) and [reviews/](.); the tangent object $[\Omega,V]$ across the same; the $V$ equation's other contractions; and the Lean layer by declaration name.

**What the search found, and it is all this round's own output.** The bracket appears at [fence-posts.md](../findings/fence-posts.md) post F69's fifth instance, at [INDEX-traps.md](../findings/INDEX-traps.md) row 69, and in [routes.md](../routes.md)'s R28 row, all three introduced by commit `1cda9302`, with [frame_first_order_vacuous](../lean/HamiltonsCubic/Results/I106Criticality.lean) introduced by `32d26fe1`. Those are the block propagating itself, not an independent prior.

**Three near neighbours that are genuinely distinct, and should not be folded together.**

- [orbit_first_order_vacuous](../lean/HamiltonsCubic/Results/I106Criticality.lean), batch 33, is $[\hat U,A]+[V,C]=0$ for the **joint** conjugation. It is the same phenomenon in a different direction, and the block is right that the two directions differ.
- Batch 20's $2\beta\operatorname{tr}(\hat UV^2)+\langle V,C\rangle=\mu\lvert V\rvert^2$ is the **same equation contracted against $V$**, where the frame condition is the same equation bracketed with $V$. Different components, so neither states the other.
- Post F69's fourth instance, batch 34, reaches the post through a field pairing rather than through a restated condition, and is not this.

**So the honest form of the record's sentence** is that the frame direction's first order is a fresh instance of post F69 in a direction not previously taken, whose vacuity was already implied by batch 21's standing premise. The instance is worth posting. Claim 8 as written is too strong.

## What to repair on the record

1. **Drop the batch 22 citation for the second-order half** in [fence-posts.md](../findings/fence-posts.md) post F69's fifth instance, in [INDEX-traps.md](../findings/INDEX-traps.md) row 69, and in [routes.md](../routes.md)'s R28 row, all three of which say the second order "is batch 21 at $X=0$, which batch 22 already records as known to be at most zero". Batch 22's $a$ covers the frame directions only for $\Omega\perp K$. Cite batch 21's $X=0$ specialisation instead, which covers them all.
2. **Hedge the control's reach** in the same three places. The generic-field contrast shows the expression is not identically zero. It does not show the collapse is "the substitution rather than the geometry", because the substituted point is the critical one and the generic point is not.
3. **Name the symmetry step** in claim 3, at the block and at the [frame_first_order_vacuous](../lean/HamiltonsCubic/Results/I106Criticality.lean) docstring: stationarity gives $[V,M]=0$ rather than $\operatorname{skew}[V,M]=0$ because $V$ and $M$ are symmetric. The trace step itself needs only cyclicity, and the docstring may say so.
4. **The cited screen is not filed.** Post F69's fifth instance cites figures of $23.79$ and $3.7\cdot10^{-15}$ over twenty thousand triples with no script behind them, where the post's own earlier instance cites [screen_I106_commutator.py](../scripts/misc/screen_I106_commutator.py). Either file it or replace the figures with the exact identity of claim 5, which is stronger and needs no run.

## The Lean table, two rows that can be improved

| # | brief's row | r967 |
|---|---|---|
| 3 | none for the unsubstituted condition, the layer has no differential | Agreed for the variation. The **algebraic** half is typeable and untyped: that $\operatorname{tr}([\Omega,V]M)=\operatorname{tr}(\Omega[V,M])$ and that $[V,M]$ is skew for symmetric $V$, $M$, which is where symmetry enters |
| 5 | none, a non-vanishing claim needs an explicit witness and none is typed | The witness exists and is cheap. Type the hypothesis-free identity $[V,\beta\{\hat U,V\}+C]=\beta[V^2,\hat U]+[V,C]$, which closes by `noncomm_ring`, and evaluate it at one explicit pair with $[\hat U,V^2]\ne0$ |

Rows 1, 2, 4, 6, 7 and 8 I agree with as written.

## Method

Claims 1 to 7 were settled by hand and confirmed symbolically over generic traceless symmetric $\hat U$, $V$, generic skew $\Omega$ and a symbolic field carrying its multiple of $I$, every residual exactly $0$. The numerical figures quoted are screens on constructed objects, seconds of compute, reported as screens and never as evidence for a positive claim. No sweep, census or unbounded search was opened, so nothing here needed approval under the analysis-only footing. The working note the block was drawn from was not read.
