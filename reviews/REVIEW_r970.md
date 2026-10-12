# Review r970: is every directional lever contained in batch 21, and does that exhaust R28?

**Cold brief.** Reviewer r970 worked from [BRIEF_I106a_completeness.md](BRIEF_I106a_completeness.md) alone: the working note the block was drawn from was not read, no other reviewer's report was read, and the scripts under review were not imported. Every derivation below is by hand. Two of them were afterwards **screened** in sympy over exact rationals, and the screen is reported as a screen and is never the evidence for a positive claim. Log: [agent_logs/r970-completeness.log](../agent_logs/r970-completeness.log).

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | Batch 21's condition holds for ALL traceless symmetric tangent $(X,Y)$, along any curve, with no acceleration term | mathematics | **CONFIRMED (four hypotheses named)** |
| 2 | A lever that picks a tangent direction and computes the second variation along it is batch 21 evaluated at that direction | mathematics | **CONFIRMED** |
| 3 | Hence such a lever is implied by batch 21 and excludes nothing batch 21 does not | mathematics | **CONFIRMED (it licenses no exhaustion)** |
| 4 | The orbit, the frame variation and the radial trade are each such a direction | mathematics | **CONFIRMED (the brief's flagged trap is a non-trap)** |
| 5 | The first-order side is empty: each stationarity condition collapses to an identity under the Lagrange forms | mathematics | **CONFIRMED, and the block understates it: it is a theorem, not six instances** |
| 6 | R28 excludes an interior tangency by first and second order, and both are directional | about a method | **PLAUSIBLE in half, REFUTED in half** |
| 7 | Therefore R28's mechanism is spent among directional levers | about a method | **REFUTED, and a fourth-shape lever is exhibited** |
| 8 | The value comparison is non-directional and untouched by claims 1 to 5 | mixed | **CONFIRMED (the trichotomy is still short by one)** |

**Actionable summary.** The block's mathematics stands in full and its own conclusion does not: at a tangent direction where batch 21 holds with equality, which is exactly the interior tangency R28 is aimed at, a local maximum forces the closed-form third-order equality $P_3(X,Y) + \tfrac{T(X,Y)}{T}\big(\langle X,A\rangle + \langle Y,C\rangle\big) = 0$, which is curve-independent, is not implied by batch 21, and is neither a value comparison nor a second-variation direction.

## 0. Conventions, fixed once

Write $Z = (X,Y)$ for a pair of real traceless symmetric $3\times3$ matrices, so the ambient space is $W = \operatorname{Sym}_0(3)\oplus\operatorname{Sym}_0(3)\cong\mathbb{R}^{10}$, and $Z_0 = (\hat U, V)$ for the point under study.

- $P_3(Z) = \alpha\operatorname{tr}X^3 + \beta\operatorname{tr}(XY^2)$, the cubic part, so $\Phi = P_3 + \ell$ with $\ell(Z) = \langle X,A\rangle + \langle Y,C\rangle$ linear and $A$, $C$ **fixed external data**.
- $T(Z) = \tfrac32\lvert X\rvert^2 + \tfrac12\lvert Y\rvert^2$, a quadratic form, and $T$ without an argument means $T(Z_0)$. Its polarisation is $T_{\mathrm{bil}}$, so $DT\cdot Z = 2T_{\mathrm{bil}}(Z_0,Z)$ and the tangency form $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)$ is $2T_{\mathrm{bil}}(Z_0,Z)$.
- $g(Z_1,Z_2) = 2T_{\mathrm{bil}}(Z_1,Z_2)$ is the metric batch 21's right-hand side already uses, since $g(Z,Z) = 3\lvert X\rvert^2+\lvert Y\rvert^2$. Under $g$ the normal to the level set of $T$ at $Z_0$ **is** $Z_0$ itself, because $g(Z_0,Z) = 3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)$.
- $Q(Z) = 3\alpha\operatorname{tr}(\hat UX^2) + 2\beta\operatorname{tr}(XVY) + \beta\operatorname{tr}(\hat UY^2)$, so **batch 21's left-hand side is exactly $2Q(Z)$** and batch 21 reads $2Q(Z) \le 2\mu T(Z)$ for every tangent $Z$. Writing $f = \Phi-\mu T$, the Hessian form is $H(Z) := D^2f[Z,Z] = 2Q(Z)-2\mu T(Z)$, with polarisation $H_{\mathrm{bil}}$.
- $\mathcal{Q}$ is the $g$-self-adjoint operator of $2Q$, that is $g(Z,\mathcal{Q}Z) = 2Q(Z)$, and $\mathcal{H} = \mathcal{Q}-\mu\operatorname{Id}$. Batch 21 is then the single statement $\mathcal{H}\preceq 0$ on the tangent space $T_p$.
- $\{E_i\}_{i=1}^5$ is any basis of $\operatorname{Sym}_0(3)$ orthonormal for $\langle A,B\rangle = \operatorname{tr}(AB)$.

The two expansions the block rests on are [second_variation_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) and [constraint_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) in the same file, and both are proved there by `ring` with no hypothesis. I read both statements and they do match the $Q$ and $T$ above.

## Hypothesis inventory

What the block's argument silently uses, in the order it uses it.

| # | hypothesis | where it enters | status |
|---|---|---|---|
| H1 | $Z_0\ne 0$, so $\nabla T = (3\hat U,V)\ne 0$ and the level set is a smooth $9$-manifold near $Z_0$ | needed for "every tangent vector is some curve's velocity", which is what turns the curve statement into the quantifier over $(X,Y)$ | holds at any point with $T>0$, which is the whole programme |
| H2 | $A$ and $C$ are constants of the problem, not functions of $(\hat U,V)$ | needed for $\Phi$ to be a cubic polynomial whose second differential is $2Q$ with no $A$, $C$ term | consistent with the given, and with the Lean expansions |
| H3 | $\mu$ is *the* Lagrange multiplier, unique | needed for the inequality to be about one number | follows from H1 |
| H4 | the maximum is over the **full** level set of $T$ in $W$, with $T$ the only active constraint | needed for the quantifier to run over the whole $9$-dimensional tangent space | **not verifiable from the brief**, see §1.3 |

H4 is the one to watch. It does not threaten the block's conclusion, and §1.3 says why.

## 1. Claim 1, the load-bearing given

### 1.1 The acceleration step is correct, and this is what it needs

Let $\gamma$ be a $C^3$ curve on the level set with $\gamma(0)=Z_0$ and $\gamma'(0)=Z$. Then
$$\frac{d^2}{ds^2}\Big|_0 f(\gamma) \;=\; D^2f[\gamma',\gamma'] \;+\; Df\cdot\gamma'' .$$
The second term drops because $Df(Z_0)=0$ **on the ambient space $W$**, which is precisely what the Lagrange condition $D\Phi = \mu\,DT$ asserts. This is the standard fact that the Hessian of a function is well defined on the tangent space at a critical point, and the block states it correctly. What it needs is the ambient vanishing, not merely vanishing on the tangent space, and the Lagrange multiplier supplies exactly that. Since $T$ is constant along $\gamma$, $\tfrac{d^2}{ds^2}f(\gamma) = \tfrac{d^2}{ds^2}\Phi(\gamma)$, so a local maximum gives $H(Z)\le 0$, which is batch 21 after multiplying out.

Nothing here is restricted to curves of a special kind. The result is curve-independent **at second order**, and §4 is about what happens at the next order, where it stops being.

### 1.2 The quantifier really is over all tangent vectors

Under H1 the level set $\{T = T(Z_0)\}$ is an ellipsoid in $W$, a smooth compact $9$-manifold, so its tangent space at $Z_0$ is the full kernel of $Z\mapsto 3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)$ and every element of that kernel is the velocity of a curve on it. An explicit witness, used again in §4: $\gamma(s) = \rho(s)\,p(s)$ with $p(s)=Z_0+sZ+\tfrac{s^2}{2}\Omega$ for any $\Omega\in W$ and $\rho(s) = \sqrt{T/T(p(s))}$, which lies on the level set identically because $T$ is a quadratic form, and which has $\gamma'(0)=Z$ exactly when $Z$ is tangent. So the quoted sentence does give the condition at every tangent direction. **CONFIRMED.**

### 1.3 The one hypothesis the brief does not state, and which way it cuts

Batch 21 quantifies over the tangent space of $\{T = \text{const}\}$ in the full $W$. If R28's maximiser is constrained to a proper subfamily of $W$, for instance because $\hat U$ and $V$ are parameterised by orthostochastic data rather than free, then the admissible variations form a proper subspace and batch 21 as quoted claims more than criticality supplies. I cannot settle this from the brief, which names one constraint and one multiplier, so within the brief's own setting claim 1 is right.

It is worth saying which way the risk runs. **Shrinking the quantifier would weaken claim 1 and leave claims 2 and 3 untouched**, because a directional lever restricted to the same subfamily is still an instance of the correspondingly restricted batch 21. So H4 is a hypothesis about the truth of claim 1, not a route to the block's conclusion being wrong. The routes to that are in §4 and §5.

## 2. Claims 2 and 3, where the reader nods

As worded, claim 2 is close to a definition, and the algebra behind it checks out: [second_variation_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) gives the order-two part of $\Phi(Z_0+Z)$ as $3\alpha\operatorname{tr}(\hat UX^2)+\beta\big(2\operatorname{tr}(XVY)+\operatorname{tr}(\hat UY^2)\big)$, which is $Q(Z)$, and [constraint_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) gives the constraint's order-two part as $T(Z)$ with the tangency form as its order-one part. So the second variation along a direction is $2Q(Z)-2\mu T(Z)$ evaluated there, which is batch 21's expression. **CONFIRMED**, and claim 3 follows immediately: one instance of a universally quantified inequality is implied by it. **CONFIRMED.**

The brief invites an attack here, on whether a directional lever could compute something other than the second variation. It could, and §4 exhibits one. But that attack lands on the block's *inference*, not on claim 2's sentence, which names the second variation explicitly. I record the distinction rather than blur it: claims 2 and 3 are true, and the equivocation appears only when "directional lever" silently widens from "second-variation lever" to "any lever that picks a direction". That widening happens in claim 7, and it is graded there.

**A second thing claim 3 does not license, and this matters more than it looks.** "Implied by batch 21" is not "equivalent to the three levers on the record". Batch 21 is a statement quantified over a $9$-dimensional space, and the orbit, the frame variation and the radial trade are three of its points. A method can therefore be strictly inside batch 21 and still have most of batch 21 unharvested. §5 makes that concrete with two consequences of batch 21 that no single direction gives.

## 3. Claim 4, and the trap that is not one

All three are tangent, and each is traceless symmetric.

- **Conjugation orbit**, $X=[\Omega,\hat U]$, $Y=[\Omega,V]$ with $\Omega$ skew. Symmetry: $[\Omega,\hat U]^{\mathsf T} = \hat U^{\mathsf T}\Omega^{\mathsf T}-\Omega^{\mathsf T}\hat U^{\mathsf T} = [\Omega,\hat U]$, which needs $\Omega$ skew and $\hat U$ symmetric. Tangency: $\operatorname{tr}(\hat U[\Omega,\hat U]) = \operatorname{tr}(\hat U^2\Omega)-\operatorname{tr}(\hat U^2\Omega)=0$ by cyclicity, and the same for $V$, so the tangency form vanishes term by term.
- **Frame variation**, $X=0$, $Y=[\Omega,V]$. The tangency form is $3\operatorname{tr}(\hat U\cdot 0)+\operatorname{tr}(V[\Omega,V]) = 0$. Stronger: the curve $s\mapsto(\hat U, e^{s\Omega}Ve^{-s\Omega})$ preserves $T$ **exactly**, not merely to first order.
- **Radial trade**, $X=\lambda\hat U$, $Y=\kappa V$. Tangency is $3\lambda\lvert\hat U\rvert^2+\kappa\lvert V\rvert^2=0$, which the lever carries as its own defining constraint.

**The brief's flagged worry about $\operatorname{tr}(\hat U[\Omega,V])$ is a non-trap, and I say so rather than leave it silent.** The tangency form is $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)$, and at $X=0$ it contains no $\hat U$ term at all, so $\operatorname{tr}(\hat U[\Omega,V])$ is never required to vanish. It is generically non-zero, and it is harmless: it sits in the cross term $2\beta\operatorname{tr}(XVY)$ of the second variation, which is itself zero at $X=0$. **CONFIRMED**, all three.

One qualification on the frame variation's standing as a *lever*: its first-order content is vacuous, as [frame_first_order_vacuous](../lean/HamiltonsCubic/Results/I106Criticality.lean) types, so the whole of what it contributes is batch 21 at $X=0$, namely $2\beta\operatorname{tr}(\hat UY^2)\le\mu\lvert Y\rvert^2$. It is a lever at second order and at no other.

## 4. Claim 5, and a lever of a fourth shape

### 4.1 The first-order side is empty as a theorem, so "six instances" understates it

Apply post F69's test, and it settles the general case in one line rather than six. The two Lagrange forms are **the general solution of $\nabla\Phi = \mu\nabla T$ on $\operatorname{Sym}_0\oplus\operatorname{Sym}_0$**, each modulo the multiple of $I$ that the traceless pairing cannot see:
$$\partial_{\hat U}\Phi = 3\alpha\hat U^2+\beta V^2+A,\quad \partial_{\hat U}(\mu T)=3\mu\hat U \;\Longrightarrow\; A \equiv 3\mu\hat U-3\alpha\hat U^2-\beta V^2,$$
$$\partial_{V}\Phi = \beta\{\hat U,V\}+C,\quad \partial_{V}(\mu T)=\mu V \;\Longrightarrow\; C \equiv \mu V-\beta\{\hat U,V\},$$
which are exactly the given fields. Any first-order directional condition is $\langle\nabla(\Phi-\mu T),Z\rangle = 0$ for some $Z$, a single component of an equation that is an identity once those forms are substituted. So **no seventh instance can survive**, and none of the six is evidence for anything beyond that line. The block is right and too modest, and "now at six instances" invites a reader to wonder whether a seventh might break the pattern. It cannot.

The collapse reaches past directional conditions to any algebraic consequence of the two field equations. Batch 30's $\mu K-\beta\{\hat U,K\} = [\hat U,C]$ with $K=[\hat U,V]$ is one: substituting $C$ gives $[\hat U,C] = \mu K-\beta[\hat U^2,V]$, and $\{\hat U,K\} = \hat U^2V-V\hat U^2 = [\hat U^2,V]$ is a ring identity, so the two sides agree with no hypothesis. **CONFIRMED, strengthened.**

### 4.2 The consequence the block does not draw: at a tangency the third order bites, in closed form

This is the answer to the brief's standing question, and it is the most valuable thing in this report.

Batch 21 is an inequality. Where it is **tight** at a tangent direction $Z$, that is where the restricted Hessian has $Z$ in its kernel, a local maximum forces more, and the more is not in batch 21. The third derivative along a curve at a critical point is
$$\frac{d^3}{ds^3}\Big|_0\Phi(\gamma) \;=\; 6P_3(Z) \;+\; 3\,H_{\mathrm{bil}}(Z,\gamma''(0)),$$
the $Df\cdot\gamma'''$ term dropping for the same reason as in §1.1. In general this **does** depend on the curve's acceleration, so the block's "no contribution from the curve's acceleration" is a second-order fact and not a general one. At a degenerate $Z$ the dependence disappears again, for a reason worth stating positively: degeneracy means $H_{\mathrm{bil}}(Z,\cdot)$ annihilates the whole tangent space, so only $\gamma''$'s normal component survives, and the constraint fixes that component. Writing $\gamma'' = \gamma''_{\mathrm{tan}}+cZ_0$, differentiating $T(\gamma)=\text{const}$ twice gives $2T(Z)+DT\cdot\gamma''=0$, hence $c = -T(Z)/T$.

The remaining pairing has a clean closed form, and **this is where the Lagrange fields re-enter**. Polarising $Q$ against $Z_0$, and using $\operatorname{tr}(\hat UVY)=\operatorname{tr}(\hat UYV)$ for symmetric matrices,
$$Q_{\mathrm{bil}}(Z,Z_0) \;=\; 3\alpha\operatorname{tr}(\hat U^2X)+\beta\operatorname{tr}(V^2X)+\beta\operatorname{tr}(\{\hat U,V\}Y) \;=\; \mu\big(3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)\big)-\ell(Z) \;=\; -\ell(Z)$$
for tangent $Z$, the middle step being the substitution of both Lagrange forms and the last being tangency. Since $T_{\mathrm{bil}}(Z,Z_0)=0$ as well, $H_{\mathrm{bil}}(Z,Z_0) = -2\ell(Z)$. Assembling:

> **At every tangent direction $Z=(X,Y)$ where batch 21 holds with equality, a local maximum forces**
> $$P_3(X,Y) \;+\; \frac{T(X,Y)}{T}\Big(\langle X,A\rangle+\langle Y,C\rangle\Big) \;=\; 0 ,$$
> **with $P_3(X,Y)=\alpha\operatorname{tr}X^3+\beta\operatorname{tr}(XY^2)$ and $T(X,Y)=\tfrac32\lvert X\rvert^2+\tfrac12\lvert Y\rvert^2$.**

Four things make this the fourth shape the brief asked for.

1. **It is not implied by batch 21.** Batch 21 constrains a quadratic form. This is an equality between a cubic form and a linear one, at directions batch 21 has nothing left to say about.
2. **It is curve-independent even though it is third order**, so it is a legitimate directional condition, and it defeats the reading of claim 2 in which every direction-picking lever is batch 21 evaluated there.
3. **It is in closed form in the data already on the record**, $\alpha$, $\beta$, $A$, $C$ and the direction, with no new object to construct.
4. **Its hypothesis is exactly R28's target.** Claim 6 says R28 excludes an *interior tangency*. A tangency is the degenerate case, so the condition applies where R28 is already looking rather than in some hypothetical corner. The Lean file's own note on [disc_of_nonpos'](../lean/HamiltonsCubic/Results/I106Criticality.lean), that only $a\le 0$ is established and its screen puts $\min(-a)$ at $8.8\times10^{-4}$, is a second reason to expect the degenerate boundary to be live rather than vacuous.

Where degeneracy holds and this equality also holds, the next lever is the fourth derivative, which I have not put in closed form and which I record as open rather than claim.

**Screen.** The two identities that carry this, $H_{\mathrm{bil}}(Z,Z_0)=-2\ell(Z)$ for tangent $Z$, and $\tfrac{d^3}{ds^3}\Phi(\gamma)\big|_0 - 3H_{\mathrm{bil}}(Z,\gamma''_{\mathrm{tan}}) = 6P_3(Z)+6\tfrac{T(Z)}{T}\ell(Z)$ along the explicit curve of §1.2, were screened in sympy over exact rationals at $\alpha=\tfrac{15}{4}$, $\beta=\tfrac94$, with $A$ and $C$ defined by the Lagrange forms so that criticality holds by construction, and with $\mu$ carried as a symbol. Both residuals are identically zero. This is a screen on objects built for the purpose and the derivation above stands on its own.

## 5. Claims 6 and 7, which are not mathematics

I keep these separate from §1 to §4 and do not let the mathematics carry them.

### 5.1 The block draws the line in the right place

The block says of claim 7 that it is "a judgement rather than a theorem", and that "the mechanism has no other lever" is a claim about a method rather than about the objects. **That is correct and it is the right place for the line.** There is no type of "lever", so there is no proposition to prove, and the Lean table's "none: it quantifies over LEVERS, which is not a type in the layer" is an honest row rather than an evasion. The block's epistemic hygiene is sound.

### 5.2 Claim 6, half checkable and half not

The first half, that R28 excludes an interior tangency by first and second order on the orthostochastic data, is a statement about R28's content and **this brief carries no R28 text**, so my finding on that half is: this claim has no argument on file here, and I grade it neither way.

The second half, "both of those are directional", is checkable and is wrong in both legs, in opposite directions.

- **The first-order leg is not a directional lever, it is no lever at all.** §4.1 shows every first-order directional condition is an identity under the Lagrange forms. Counting it as one of two directional legs makes R28 look like it has two kinds of content where it has one.
- **The second-order leg is a form, and a method may use the form rather than its values.** Calling it directional presumes that the only way to use $\mathcal{H}\preceq 0$ on a $9$-dimensional space is to evaluate it at chosen vectors. §5.3 gives two uses that are not evaluations.

**PLAUSIBLE in half, REFUTED in half.**

### 5.3 Claim 7 is refuted, and here is the shape that refutes it

Besides §4.2, which escapes batch 21 outright, there is a second and gentler shape: **aggregate consequences of batch 21 that no single direction yields**. These stay inside batch 21, so claim 3 survives them intact. What they refute is the step from "contained in batch 21" to "spent".

**The trace, which is free of $\alpha$ and $\beta$.** For an orthonormal basis of $\operatorname{Sym}_0(3)$, $\sum_i E_i^2$ is an $O(3)$-invariant symmetric matrix, hence a multiple of $I$, and the explicit basis gives $\sum_iE_i^2=\tfrac53 I$. So $\sum_i\operatorname{tr}(\hat UE_i^2) = \tfrac53\operatorname{tr}\hat U = 0$ by tracelessness, and the whole $Q$ part of the $g$-trace vanishes: taking the $g$-orthonormal basis $(E_i/\sqrt3,0)$ and $(0,E_i)$,
$$\operatorname{tr}_g\mathcal{Q} = 0,\qquad \operatorname{tr}_g\mathcal{H} = -10\mu .$$
Subtracting the $g$-unit normal $Z_0/\sqrt{2T}$, at which $H$ takes the value $(3P_3-\mu T)/T$ because $Q(Z_0)=3P_3(Z_0)$, leaves $\operatorname{tr}_g\mathcal{H}\big|_{T_p} = -9\mu - 3P_3/T$, and batch 21 makes it non-positive:
$$\boxed{\;P_3 \;\ge\; -3\mu T\;}$$
equivalently $\Phi \le 8\mu T$ through [value_at_critical](../lean/HamiltonsCubic/Results/I106Criticality.lean)'s $\Phi = 2\mu T-2P_3$. I report honestly that this particular bound looks weak. Its interest is its shape, and that $\alpha$ and $\beta$ cancel out of it entirely.

**Cauchy interlacing, which is the substantial one.** A $g$-self-adjoint operator that is $\preceq 0$ on a codimension-one subspace has at most one positive eigenvalue, so with $\lambda_1\ge\lambda_2\ge\dots$ the eigenvalues of $\mathcal{Q}$,
$$\boxed{\;\mu \;\ge\; \lambda_2(\mathcal{Q})\;}$$
a bound on the multiplier read off by diagonalising one fixed $10\times10$ operator assembled from $\hat U$, $V$, $\alpha$ and $\beta$, with **no tangency constraint to solve and no direction to choose**. It is strictly weaker than batch 21, as it must be, and it is strictly stronger than any finite list of directional instances. Nothing on the record extracts it.

**Screen.** $\sum_iE_i^2=\tfrac53I$, $\operatorname{tr}_g\mathcal{H}=-10\mu$ and $\operatorname{tr}_g\mathcal{H}|_{T_p}=-9\mu-3P_3/T$ were screened in sympy over exact rationals with $\mu$ symbolic. All three residuals are identically zero.

So the correct classification is not two boxes but four:

1. **an instance of batch 21 at a chosen direction**, which is what the block proves is contained,
2. **an aggregate consequence of batch 21 over the tangent space**, the trace and the interlacing bound above,
3. **a third-order condition at a direction where batch 21 is tight**, §4.2,
4. **a value comparison**, batch 29.

The block has the first and the fourth, and its conclusion needs the middle two to be empty. They are not. **REFUTED.**

## 6. Claim 8, the value comparison

The value comparison of batch 29 tests $\Phi(Z_0)$ against $\Phi$ at another configuration of the same $T$. Claims 1 to 5 are all statements at $Z_0$ and all are infinitesimal, so none of them reaches a finite comparison between two points, and no tangent direction reproduces it: a direction yields a derivative, and a derivative at $Z_0$ says nothing about a distant point of the level set. The level set is connected and compact, so the two points are joined by a curve and the comparison is that curve's integral, but the integral is not determined by the integrand's value at one endpoint. **CONFIRMED.**

One qualification, which is about the block's trichotomy rather than about claim 8. There is a compound shape the dichotomy misses: **batch 21 applied at the competitor configuration**, which is neither a direction at $Z_0$ nor a value comparison, and which is available whenever the competitor is itself critical. That is a fifth box, weaker and more speculative than §4.2 and §5.3, and I record it as a direction to look rather than as a finding.

## Overall verdict

**GAP.** The mathematics of claims 1 to 5 is sound and I found no error in it: claim 1 holds with H1 to H4 named, claims 2, 3 and 4 hold as written, and claim 5 is stronger than the block says. The block is also right to label claims 6 and 7 a judgement rather than a theorem. **The judgement itself is wrong**, and the gap is between "every second-variation lever is contained in batch 21", which is true, and "R28's mechanism is spent", which needs batch 21 to be exhausted by three of its points and needs the second-order data to have no non-directional use. The named gap has a concrete filler: the third-order equality of §4.2, which holds exactly at the interior tangency R28 is aimed at and which batch 21 does not imply.
