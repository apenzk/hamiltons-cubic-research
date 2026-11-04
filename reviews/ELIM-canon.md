# ELIM-canon, elimination audit of the canon and three findings files

*Auditor ELIM-canon, 2026-09-01. Assigned: [results.md](../results.md), [findings/isotropy-cap.md](../findings/isotropy-cap.md), [findings/ungraded-slack.md](../findings/ungraded-slack.md), [findings/route-a.md](../findings/route-a.md). All four read in full. **No numerical work was done**: every substitution below is hand algebra from $W^\#=\theta W-W^2$, $\mathrm{Ric}(W)=0$, first Bianchi, $\mathop{\mathrm{tr}}W=0$, $\lVert W\rVert=1$.*

The test applied to every bound, reduction, equivalence and "the conjecture becomes" in the four files: substitute criticality, then ask what free variable survives. Survivors first, because they are what changes future cycles.

---

## Survivors, what genuinely escapes $(\text{spectrum},\theta)$

### S1. The bracket-defect budget is a constant, and only its *distribution* is free

Write $\Delta_a:=\lVert[\mathrm{ad}(v_a),W]\rVert^2$ for each eigenvector, so that the symmetry defect of [results.md](../results.md) is $\Delta(W)=\sum_{\delta\in\mathfrak p}\Delta_\delta$. In the eigenframe $(\mathrm{ad}\,v_a)_{cb}=c_{abc}$ and $[\mathrm{ad}(v_a),W]_{cb}=c_{abc}(\lambda_b-\lambda_c)$, so

$$\Delta_a=\sum_{b,c}c_{abc}^2(\lambda_b-\lambda_c)^2=2\underbrace{\sum_b\lambda_b^2\lVert[v_a,v_b]\rVert^2}_{=:B_a}-2\sum_{b,c}c_{abc}^2\lambda_b\lambda_c .$$

Hamilton's $\#$ in the eigenframe gives $(W^\#)_{aa}=\tfrac12\sum_{b,c}c_{abc}^2\lambda_b\lambda_c$, and criticality forces $(W^\#)_{aa}=\lambda_a(\theta-\lambda_a)$. Hence, **at every critical point**,

$$\boxed{\ \Delta_a=2B_a-4\lambda_a(\theta-\lambda_a)\ },\qquad B_a=\sum_b\lambda_b^2\lVert[v_a,v_b]\rVert^2 .$$

Summing over the whole eigenbasis, using $\sum_b\lVert[v_a,v_b]\rVert^2=\kappa=2(n-2)$ (the Killing constant this record already uses in [Lemma L23](../findings/ungraded-slack.md)), $\sum\lambda_b^2=1$ and $\mathop{\mathrm{tr}}(W^\#)=\theta\mathop{\mathrm{tr}}W-\mathop{\mathrm{tr}}W^2=-1$:

$$\boxed{\ \sum_a\Delta_a=2\kappa-4\mathop{\mathrm{tr}}(W^\#)=4(n-2)+4=4(n-1)\ }$$

at **every** unit critical point, with no further hypothesis. Three consequences, and they are the deliverable of this audit.

- **The constant $4(n-1)$ in the $\lambda$-weighted bound $\theta\le\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)/4$ is this budget.** So $4(n-1)-\Delta-G_0$ is not an independent quantity: it is the residual share of a fixed total after the positive-eigenspace share $\Delta$ and the share $G_0$ are removed. A bound linear in it is a bound on how the fixed defect mass partitions, never on its size. This is why the bound is "sharp at every symmetric-space point and slack only where $\Delta>0$", sharpness is the partition degenerating, not the estimate biting.
- **$\Delta$'s entire alignment content is $B_+:=\sum_{\delta\in\mathfrak p}B_\delta$.** From the boxed identity, $\Delta=2B_+-4\big(\theta\mathop{\mathrm{tr}}W_+-\mathop{\mathrm{tr}}W_+^2\big)$, and the subtracted term is a pure function of $(\text{spectrum},\theta)$. **So "convert positive defect into a deficit in $\theta$" is, after substitution, exactly "convert a large $B_+$ into a deficit in $\theta$", and nothing else.** A successor writing an estimate in $\Delta$ is writing one in $B_+$ with a spectral term added to both sides (the R14 shape), unless the estimate is genuinely nonlinear in the spectrum.
- $B_+$ is a *genuine* survivor: it weights the bracket masses $\lVert[v_\delta,v_b]\rVert^2$ by $\lambda_b^2$, and only its total $B_++B_-=\kappa=2(n-2)$ is fixed. That total is precisely the marginal [fence post F41](../findings/INDEX.md) says buys nothing, which is consistent and which localises the remaining freedom to the *weighting*.

**Recommended framing for the live target**: state it in $B_+$, not $\Delta$. The two differ by a spectral identity, and only one of them can be estimated without re-deriving the target.

### S2. $\lVert\mathrm{Ric}(W_-)\rVert^2$ and $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$

These are the honest survivors of [Lemma L7](../results.md) and [Lemma L15](../results.md). $W$ satisfies $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$, but $W_-$ is a *spectral projection* of $W$ and satisfies neither; both quantities depend on how the negative eigenvectors sit as bivectors, and criticality says nothing about them. Lemma L7 is therefore a real inequality with real content, and its equality class (bracket-gradedness of the eigenspace ranges) is mechanism, not normalisation. **This is the strongest thing in the canon under the elimination test.**

### S3. $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ at a transverse direction

[Lemma L20](../findings/route-a.md)'s expansion parameter is evaluated at a *fixed* $u=W_{\mathbb{CP}^2}$ against a free $V$ transverse to $\mathbb Ru$ and the orbit. Criticality of $u$ is used only to kill the linear term. So $\alpha$ is not spectrum-determined, and Lemma L20 is exactly the kind of argument [Lemma L51](../results.md) says is needed: it consumes transverse directions. Lemma L20 passes cleanly.

### S4. The second spectrum $\omega$

[Lemma L50](../results.md)'s $\omega$ (the second-kind operator's spectrum) is not a function of $\mu$, that is the content of the lemma, and it is honestly credited to Dai–Fu. A survivor, though [Lemma L52](../results.md) records that the obvious coupling to it is inert.

### S5. The relaxation tensor $T_{\alpha\beta\gamma}$ in the $\le2$-negative stratum

[Lemma L35](../findings/isotropy-cap.md)'s chain runs on $\theta=\sum\lambda^3+3\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, an identity that uses no Weyl hypothesis and no criticality. $T$ is free, the pair cap is a real constraint on it, and the LP duality is proved. This route escapes the failure mode entirely, and it is the only place in the four files where a proved inequality's tightness comes from an exhibited maximiser ($t_{\alpha\beta\gamma}=2/(k-2)$) rather than from a degeneracy.

---

## Tautologies found

### T1. Conjecture L16's sharpness is a one-parameter fit, and the canon claims the opposite

[results.md](../results.md) states $P\le\theta_0(n)+\kappa_n\delta^2$ with $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ "pinned by requiring equality at the $\mathbb{CP}^2$-type competitor, whose defect is exactly $1/9$", and then asserts: *"The shape is forced, not fitted: equality holds at both named maximizers by construction, and $\kappa_n$ changes sign exactly at the crossover."*

The algebra:

- At the sphere product, $\delta^2=0$ and $P=\theta_0(n)$, so equality is the definition of $\theta_0(n)$.
- At $W_{\mathbb{CP}^2}$, $\delta^2=1/9$, so $\theta_0(n)+\kappa_n/9=\theta_0(n)+\sqrt{3/2}-\theta_0(n)=\sqrt{3/2}=P$. Equality is the definition of $\kappa_n$.
- $\kappa_n\propto\sqrt{3/2}-\theta_0(n)$ vanishes exactly where $\theta_0(n)=\sqrt{3/2}$, i.e. at $n=6+2\sqrt7$. The crossover sensitivity is $\kappa_n$'s own zero.

**One free constant fitted to one point reproduces that point, and its sign change is that point's own crossover.** All three advertised structural properties are consequences of the fit. The sentence "forced, not fitted" is contradicted by the clause immediately before it, and the glance entry's honest "sees the crossover by construction" is the correct reading. What is *not* tautological is that the inequality survives at other points, but that is the adversarial battery, which is a catalogue claim (see W1).

### T2. Lemma L17 is a statement about $\delta^2$ alone; $P$ contributes nothing

[Lemma L17](../findings/route-a.md) proves the one-sided derivative of $G=P-\kappa_n\delta^2$ is $\le0$ at $W_{\mathbb{CP}^2}$ in every direction. But $W_{\mathbb{CP}^2}$ is a **critical point of $P$** on the unit sphere, so $\mathrm dP(V)=0$ for every tangent $V$. Therefore

$$\mathrm dG(V)=-\kappa_n\,D_V(\delta^2)\qquad\text{identically},$$

and "first-order protection for every $n\ge12$" is exactly "$D_V(\delta^2)\ge0$ for every tangent $V$", multiplied by a positive constant. The reported sign reversal below the crossover ("the identical formula flips sign and reproduces the observed escape"), is $\mathop{\mathrm{sign}}(\kappa_n)$ and nothing else; it carries no information about $P$, $n$, or the escape mechanism.

The consequence for the route matters: **the same reduction happens at every critical point with $\delta^2>0$**, so Lemma L17 tests none of the interaction between $P$ and the penalty, which is the only thing Conjecture L16 needs. The genuine content, that $W_{\mathbb{CP}^2}$ one-sidedly minimises $\delta^2$ along the sphere, via the self-dual/anti-self-dual trace balance, is a real result and should be stated as such, about $\delta^2$, with the $P$ half deleted.

### T3. The slack-gap reformulation transposes a definition, and then needs something strictly harder than the target

[findings/ungraded-slack.md](../findings/ungraded-slack.md) opens the reformulation with *"The exact $\theta$ formula proven here reads $\theta\mathop{\mathrm{tr}}(W_-)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\mathop{\mathrm{tr}}(W_-^2)-S$, so the slack enters with a minus sign: ungradedness mechanically subtracts from $\theta$."*

[Observation L12](../results.md) *defines* $S:=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)$. The display is that definition moved across the equals sign. Nothing is proven and the minus sign is the definition's own.

The inference is worse than a tautology, it is a strengthening presented as a weakening. Write $R:=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\mathop{\mathrm{tr}}(W_-^2)$, so $\theta=\big(R-S\big)/\mathop{\mathrm{tr}}(W_-)$. The claimed conclusion, *"if $S\ge c>0$ then $\theta$ falls $c/\mathop{\mathrm{tr}}(W_-)$ below the graded ceiling, which the enumeration already bounds"*, needs

$$\frac{R}{\mathop{\mathrm{tr}}(W_-)}\ \le\ \text{(the graded ceiling)} .$$

But $R/\mathop{\mathrm{tr}}(W_-)=\theta+S/\mathop{\mathrm{tr}}(W_-)\ \ge\ \theta$ at every ungraded point. **So the missing hypothesis is a bound on a quantity that is provably larger than $\theta$, strictly harder than the conjecture on that set.** The enumeration bounds $\theta$ at points where $S=0$; it says nothing about $R/\mathop{\mathrm{tr}}(W_-)$ where $S>0$. This is the R14 shape exactly: the same terms subtracted from both sides.

Two further defects in the same paragraph. *"Since the gap to close is $0.324$ wide, **any** positive $c$ suffices"* is false even granting the step: the drop must exceed $\theta_0(n)-\sqrt{3/2}$, which is $0.011288$ at $n=12$ and rises to $\sqrt2-\sqrt{3/2}=0.189527$ as $n\to\infty$, positive, $n$-dependent, and unquantified in the text. And the compactness half ("if the graded set is a union of connected components, $S$ is bounded below by compactness alone, with no estimate required") inherits the hole: it delivers $c>0$ into an implication that does not carry.

### T4. The route's two advertised instruments are an identity and a restatement

[results.md](../results.md)'s "The route that now carries the argument" offers: *"the instruments already proved are equalities exactly at $\Delta=0$ points... the identity $4\theta=A-B$... and the $\lambda$-weighted bound $\theta\le\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)/4$, which is sharp at every symmetric-space point and slack only where $\Delta>0$."*

- $4\theta=A-B$ is called an identity in the same sentence. An identity holds everywhere, so "equality exactly at $\Delta=0$ points" is a category error, and an identity is not an instrument for an inequality without a separate estimate on how the mass distributes.
- The $\lambda$-weighted bound is the form [fence post F28](../findings/INDEX.md) already closes: *"No bound of the form $\theta\le\Pi/4$ can close the target, because $\Pi/4=\theta$ identically wherever $\Delta=0$ and $g$ is carried by the $\lambda_{\min}$ eigenspace, which is every catalogued point where the conjecture is tight. **It is the target restated**."* The canon still presents it as live, with its identity-forced sharpness offered as evidence of quality. **S1 above supplies the mechanism**: $4(n-1)$ is a fixed budget, so the bound reads $\theta\le\lvert\lambda_{\min}\rvert\cdot(\text{residual share})/4$.

For completeness, the deficiency identity that killed R14 is now correctly labelled an *identity* as [Lemma L70](../findings/INDEX.md), $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D/\lvert\lambda_{\min}\rvert$, which reduces to $\theta=\theta$ on substituting $\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$. **None of Lemmas 70–71 reaches [results.md](../results.md)**, so a reader of the canon alone can still propose R14 and find nothing forbidding it.

### T5. Lemma L24's "$\tfrac12$ attained by orbit directions at every critical point" is Lemma L51

The attainment clause of [Lemma L24](../results.md) is exactly $L_Wz=\tfrac\theta2z$ for $z=X\!\cdot\!W$, which [Lemma L51](../results.md) derives as an identity from equivariance with no maximality. The bound $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ is a genuine second-order condition and survives; its *sharpness* is structural and should not be cited as evidence that the bound is tight in a useful sense. The same applies to [route-a.md](../findings/route-a.md)'s "the step that could have sunk it": the containment $T_u(\mathrm{orbit})\subseteq E(\tfrac12\theta^*)$ is forced by the same identity, so the $1.4\times10^{-14}$ projector distance is evidence for one containment only. The file later derives the block-by-block equality structurally, which is the right treatment; the earlier framing overstates.

---

## Weak evidence

### W1. Conjecture L16's "full adversarial battery" is catalogue plus random screen

[results.md](../results.md): *"It has survived a full adversarial battery at $n=12$ and $n=14$ (every catalogued critical point, random sampling, seeded gradient ascent…)."* Both ingredients are the failure modes this record's own [standing rules](../findings/INDEX.md) name: the catalogue is a biased sample built from symmetric constructions, and random $\mathcal W_n$ elements are never diagonal and never symmetric-pair Casimirs. [ungraded-slack.md](../findings/ungraded-slack.md) states the disjointness directly, random-start search at $n=6$ reaches only $\theta\in[0.007,0.512]$, and "everything on file above $\theta=0.512$ arrived from a structured construction … the two populations do not meet". A battery composed of those two populations tests neither the structured high-$\theta$ region nor the generic one.

### W2. Observation L25 rests on a population the record calls unreachable

*"Across 155 converged points at $n=6$ and every structured ungraded point, $\lambda_{\max}$ runs from $1.17$ to $96.3$."* Those 155 points are the $n=6$ Levenberg–Marquardt population that [ungraded-slack.md](../findings/ungraded-slack.md) shows is disjoint from the high-$\theta$ region and lives below the crossover entirely. The canon carries none of that caveat.

### W3. "Every named structured family is graded" is refuted inside its own file

[ungraded-slack.md](../findings/ungraded-slack.md) asserts *"Every named structured family is graded, so the ungraded population has no structured members"*, supported by 61 points from two-block products and the $\mathbb{CP}^m$ family. The same file then proves **graded $\iff k\le2$** for multi-block products, evaluates $J_5$ across **505 ungraded multi-block points**, and lists ungraded quaternionic points at $0.8529,\,0.7454,\,0.6857$. Multi-block sphere products with $k\ge3$ are structured and ungraded. The heading claim is false by the file's own content, and it is load-bearing, it is the file's stated explanation of "why this half has resisted".

### W4. The Jensen point is reported graded on a screen the record calls vacuous there

Two readings of the same point coexist in [ungraded-slack.md](../findings/ungraded-slack.md). The correction paragraph says *"Jensen's entry carries $S=0$ and nothing stronger … so calling that point graded outright overstates what was measured"* (and the sentence is physically duplicated in the file). The later table says *"slack $S$ | $0$, **graded**"*, and the file draws a conclusion from it: *"So a non-symmetric homogeneous Einstein metric can have a graded Weyl operator."* The point's spectrum is $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$, **a seven-dimensional kernel**, which is exactly the case [INDEX.md](../findings/INDEX.md)'s standing warning declares uninformative: *"the gradedness screen is vacuous when $\ker W\ne0$, it traces only over $E_\pm$."* The stale reading should be struck and the conclusion withdrawn.

### W5. "Critical points are isolated modulo their orbits" is contradicted two paragraphs later

[ungraded-slack.md](../findings/ungraded-slack.md) explains the continuation failure by *"the geometry this project already established, critical points are isolated modulo their orbits, so there is no path within $\mathrm{Crit}(P)$ to ascend along"*. Isolation is proved at sphere products and $\mathbb{CP}^m$ ([Lemmas 11](../results.md), [27](../results.md), [28](../results.md)), not generically, and the file's own local-separation table records $S^3\times S^3$ at $n=6$ with $\dim\ker(\mathrm{Hess}\,P)=18$ against an orbit of $9$, i.e. **nine transverse directions**. The blanket statement should be scoped to the families where it is proved.

### W6. Rigidity at the isotropy cap is random-start evidence, and the step from subspace to operator is unsupported

[isotropy-cap.md](../findings/isotropy-cap.md): *"At the cap the rigidity forces $\mathfrak m$ onto the symmetric-pair subspace, hence $W$ onto the sphere product and $\theta$ onto $\theta_0(n)$."* Two separate problems. The conjugacy evidence is 23 of 30 random starts at $n=6$ and 10 of 10 at $n=8$, the file is explicit that symmetric-pair subspaces are measure zero and that a random search finds them with probability zero, which is the same argument the file uses two sections earlier to explain why its own census missed $d=8$. And the inferential step "hence $W$" does not follow from any statement in the file: rigidity of the **negative eigenspace** does not determine the operator, whose eigenvalues on $\mathfrak m$ and $\mathfrak h$ are unconstrained by the cap argument. [Lemma L36](../results.md) itself claims only the dimension cap and is correctly stated; the "hence $W$" clause should be either proved or deleted.

### W7. Lemma L32's degenerate case is a one-clause sketch

[isotropy-cap.md](../findings/isotropy-cap.md) proves the centraliser collapse "for nondegenerate $x$", then covers everything else with *"For degenerate $x$ the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$."* [results.md](../results.md)'s Lemma L32 states the result for all nonzero $x$ under a **Lemma** label. The exhaustive checks at 29 multiplicity partitions are evidence for the sketch, not a proof of it.

### W8. Already caught by the record, listed so they are not re-derived

[isotropy-cap.md](../findings/isotropy-cap.md) self-corrects three instances of the third defect and one of the second, and it does so well: *(i)* $(b+c)^2+b^2+c^2\ge1$ is Cauchy–Schwarz and the "identity on the base-case family" claim was vacuous because that family has one positive eigenvalue, where Cauchy–Schwarz is an equality **by definition**; *(ii)* $\sup G=\sqrt{3/2}$ at every $k$, the recorded per-$k$ decrease was a maximum over random draws, hence a lower bound; *(iii)* "all steps tight on the base-case family" tests two of five steps, the rest being vacuous at $k=1$. Also correctly labelled: the $m\ge10$ SDP screen (*"rank classes are exhausted; relative positions inside each class are still sampled, so this is evidence and not a proof"*) and the withdrawn $4$-subspace Casimir cross-check that "sits inside the null". **This file is the model for the other three.**

---

## Clean, passes the substitution test, one line each

- **Lemma L7**, the surviving quantities $\lVert\mathrm{Ric}(W_-)\rVert^2$, $\delta^2$ are not spectrum-determined; the equality class is mechanism.
- **Lemma L13**, the ceiling comes from $\mathop{\mathrm{tr}}(L_W^2)$ being constant in $W$; a structural closure, not a fit.
- **Lemma L20**, bootstrap on the attained maximum, transverse directions consumed, contradiction with the value.
- **Lemma L21**, the multiplicity spaces absorb multiplicities; a fixed finite computation on four blocks.
- **Lemma L26**, states plainly that criticality is unused and that it bounds $\lambda_{\max}$ from below only.
- **Lemma L29 / 30 / 31 / 33 / 34 / 35**, the $\le2$-negative chain; free tensor $T$, exhibited maximiser, LP weak duality proved rather than sampled.
- **Lemma L36**, the $\lfloor n^2/4\rfloor$ cap; the two-lemma chain $4d^2/n-2d\le\mu\le(n-2)d$ verifies by hand, with the $-2$ eigenvalue on $\mathrm{Weyl}_n$ carrying the whole argument.
- **Lemma L42** (the sharp dual weight), harmonic-mean feasibility plus weak duality, with the equality case exhibited; the "$2800$ draws" correctly demoted to a check on a theorem.
- **Lemma L50 / 51 / 52**, an identity honestly credited, a vacuity theorem, and a closure; none claims more than it has.
- **Lemma L23**, the closed form and the sum-of-squares cap are correct; see the staleness note below on how the canon oversells it.
- **The $\gamma=2S_{\mathfrak{mhh}}$ chain** in [isotropy-cap.md](../findings/isotropy-cap.md), verified where it discriminates rather than where both sides vanish, which is the right test and is stated as such.

---

## Staleness of the canon against [findings/INDEX.md](../findings/INDEX.md)

[results.md](../results.md) carries **42** numbered entries (1–36, 44, 47, 48, 50, 51, 52). The index owns **70** and reports "next free number: 72". Ordered by cost.

### Stale-1, the route's "factor of room" is two generations out of date, and it is the canon's stated reason for choosing the route

[results.md](../results.md) twice: *"the highest $\theta$ ever recorded on $\{S=0,\Delta>0\}$ is $0.670820$, at the $C_5$ blow-up, against a target of $1.224745$, **a factor of $1.83$ of room** … **This is the only sub-statement in the programme with a factor of room**, and it is where the argument now goes."*

The index's value table records the $C_5$ blow-up as *"highest $S=0$, $\Delta>0$ point **at $n=10$**, **no longer the ceiling**"*, and records two later displacements: $0.716134$ at $n=12$ (highest diagonal such point, *"it displaces the $C_5$ blow-up as the ceiling"*) and **$1.088948$ at $n=8$**, *"the highest $\{S=0,\ \Delta>0\}$ critical point on record, and NON-diagonal … **It cuts the margin to $\sqrt{3/2}$ from $1.71\times$ to $1.12\times$**."* Neither number appears anywhere in [results.md](../results.md). The route is chosen in the canon on a margin of $1.83$ that the record puts at $1.12$.

### Stale-2, the canon's remaining statement has a hypothesis its own record calls vacuous at the extremal point

[results.md](../results.md)'s "What is missing": *"For every even $n\ge12$: if $Q(W)=\theta W$ with $\lVert W\rVert=1$, $S(W)=0$ and $\Delta(W)>0$, then $\theta\le\sqrt{3/2}$."* The index carries a standing warning that [results.md](../results.md) never mentions, the word "kernel" appears in it only about Hessians: *"the gradedness screen is vacuous when $\ker W\ne0$, it traces only over $E_\pm$, so a point whose kernel carries most of $\mathfrak{so}(n)$ reports $S=0$ while admitting no grading; **padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$**. Trust it only at $\ker W=0$."* Padded $W_{\mathbb{CP}^2}$ is the point at which the target's conclusion $\sqrt{3/2}$ is attained. **The target statement's extremal case is precisely where its own hypothesis carries no information.** The index also lists this as one of four separate failures at $\ker W\ne0$, including *"$\Delta=0\Rightarrow$ equivariant becomes unsound"*, which is the implication [results.md](../results.md) uses to derive gradedness from $\Delta=0$ in the paragraph that defines the route.

### Stale-3, "graded" has three incomparable senses in the index and one in the canon

The index: *"**(C) pair-graded** and **(A) sign-graded** each imply **(B) slice-graded**, and **neither implies the other**: $\mathbb{CP}^2$ is (C) not (A) … A claim proved in one does not transfer to the other."* [results.md](../results.md) uses one word throughout and moves freely between the defect definition ($\Delta=0$, sense A) and the symmetric-pair classification (Lemmas 7, 8, sense C). Every "the graded half is settled / the split is exact" sentence in the canon needs a sense attached.

### Stale-4, "the graded half is settled" is overstated

Canon headline: *"Graded half of the core | **Settled** across the classical symmetric pairs (Lemmas 7–8, 10)"*. Index: *"**Settled only over the EQUIVARIANT graded points.** Lemma L8 pins $\theta$ from the pair's dimensions, which holds for the pair's equivariant critical point; a **second** graded critical point on the same pair $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ sits at $\theta=1.088948$ against $S^3\times S^5$'s $1.115547$, with identical Killing spectrum. *Candidate, Gate 2 owed*."* The same $1.088948$ as Stale-1: the point that breaks "settled" is the point that breaks "1.83 of room".

### Stale-5, Lemma L1 is labelled Proven/Gate 2 and the index says it was never audited

The canon's own label rule is *"**Lemma** is proven, Gate 1 and Gate 2 passed"*, and the headline table gives *"The granted assumption, repaired at $n=12,14$ | **Proven** (Lemma L1)"*. The index's file map: *"**Lemma L1, the diagonal case at $n=12,14$, never audited and load-bearing.**"* Everything in the programme rests on it.

### Stale-6, Lemma L22's label outruns its file

[results.md](../results.md) lists Lemma L22 as **Proven** and its detail entry is three sentences that state neither dependency. [route-a.md](../findings/route-a.md) states both: *"The vanishing $M_{W_1}\Pi_{\ker}Q(W_1)=0$ is verified at $n=12,14,16$ rather than proven"*, the four coupling vanishings it rests on are *"exhaustively verified numerics, not proofs, and proving them is blocked"* after three cycles and six dead explanations, and *"both branches use the sphere-product value as their constant, so the estimate is conditional on the conjecture at critical points past $n=12$."* The conditionality is legitimate (it matches Conjecture D's form) but must appear in the canon.

### Stale-7, 29 numbered results are absent, including headline-grade ones

Missing from [results.md](../results.md): **0, 37, 38, 39, 40, 41, 42, 43, 45, 46, 49, 53, 54, 55, 56, 57, 58, 59, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71**. Whole subjects with no representation in the canon:

| Absent | What it is | Owner |
| --- | --- | --- |
| 59, 61–65 | the $\mathrm{Sym}^3$ certificate route, **$\Theta_5=\sqrt{3/2}$ by an exact rational SOS certificate**, the $n$-independent block table with $12$ proved as the threshold, the Brauer monomial | [sym3-blocks.md](../findings/sym3-blocks.md), [sym3-stability.md](../findings/sym3-stability.md), [brauer-pairing.md](../findings/brauer-pairing.md) |
| 70, 71 | the deficiency identity (**the R14 resolution**) and its saturation theorem, unconditional for $n\ge5$ | [bounds.md](../findings/bounds.md) |
| 57 | the diagonal theorem at **all $n$, both parities**, two independent Gate 2 proofs | [problem.md](../findings/problem.md) |
| 37 | diagonality decided by a single kernel, the test that makes the live target well posed | [target.md](../findings/target.md) |
| 66, 68, 55 | no maximiser is $\circ$-decomposable; the symmetry defect in closed form; the min-entry bound | [support-dichotomy.md](../findings/support-dichotomy.md), [diagonal-half.md](../findings/diagonal-half.md) |

The canon also carries **no fence-post register**; the index lists 33, several of which (28, 34, 36, 41) bear directly on routes the canon presents as live.

### Stale-8, a citation error in the headline table

*"**Conjecture A on every compact symmetric space, $n\ge12$** | **PROVEN**, Gate 2 by four reviewers (Lemmas 37–39, 47–48)"*. Lemmas 38, 39, 47, 48 match. **Lemma L37 is "diagonality is decided by a single kernel"** in [target.md](../findings/target.md), unrelated to the symmetric-space theorem. And 37, 38, 39 have no blocks in [results.md](../results.md) at all, so three of the five cited numbers cannot be looked up in the file that cites them.

### Stale-9, Lemma L23's "separating on its own" is denied by its own file

Canon: *"It is the first place where the graded/ungraded split does the separating on its own."* [ungraded-slack.md](../findings/ungraded-slack.md), twice: *"the cap **is** the graded compression inequality restricted to this family, a sum-of-squares re-derivation and a cross-check rather than independent leverage."* The canon's detail entry omits the whole "What it does not reach" paragraph, including that the family has no near-extremal member other than the extremum ($\theta/\theta_0$ jumps $1.000\to0.845$) and that $W_{\mathbb{CP}^3}$ ties $\theta_0(6)$ from outside it.

### Stale-10, small, in [route-a.md](../findings/route-a.md)

- The file header says the route "in the register is [R4]", the first section heading says "**Route R1**, the tube around the $\mathbb{CP}^2$ orbit". One of them is wrong.
- *"this is the single remaining gap between **Lemma L18** and a complete proof"*, Lemma L18 is the lifting chapter; the tube is Lemmas 20–21. Stale cross-reference.
- The Lemma L20 proof cites $\alpha\le1/3$ as *"Nienhaus Theorem 4.14**(c)**"* while the corrections list in the same file retracts the six-case reading in favour of cases (a)–**(g)**. Worth re-checking which case is meant.
- The constants table is broken: the row `$\sup T(W_1,N,N)$ | $\sqrt{2/3}$` is orphaned below a parenthetical paragraph, outside the table it belongs to.
- [ungraded-slack.md](../findings/ungraded-slack.md)'s Lemma L38 and Lemma L58 blocks are raw LaTeX pasted from [report/](../report/), `\CP`, `\su`, `\so`, `\kk`, a `center`/`tabular` environment, and a malformed `$W_{\CP^2**$ itself.}`, which will not render and cannot be corrected in place as markdown.

---

## What a successor should take from this

1. **Restate the live target in $B_+=\sum_{\delta\in\mathfrak p}\sum_b\lambda_b^2\lVert[v_\delta,v_b]\rVert^2$, not in $\Delta$.** They differ by $4(\theta\mathop{\mathrm{tr}}W_+-\mathop{\mathrm{tr}}W_+^2)$, a spectral identity, and $\sum_a\Delta_a=4(n-1)$ is fixed, so any estimate written in $\Delta$ and a total is an estimate on a partition of a constant.
2. **Delete the sharpness arguments for Conjecture L16 and Lemma L17 from the evidence column.** One is a one-parameter fit; the other is $D_V(\delta^2)\ge0$ with $P$'s contribution identically zero at a critical point. Keep both results, stated as what they are.
3. **Repair the slack-gap reformulation or retire it.** As written it needs a bound on $R/\mathop{\mathrm{tr}}(W_-)\ge\theta$, which is strictly harder than the conjecture on the ungraded set.
4. **Bring the canon to the index before the next cycle chooses a route on it**, the $1.83$-versus-$1.12$ margin, the $\ker W$ vacuity, and the three senses of "graded" all change what the remaining problem is.
