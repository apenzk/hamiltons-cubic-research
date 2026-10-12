# Step 8 sweep, 2026-09-03

*Opens from [the position file](2026-09-03-step8-position.md). Appended after every batch, per [Phase 2](../.claude/skills/research-loop/SKILL.md).*

## Batch 1, the two statements stripped of this programme's names

**The rule this batch is testing**: *ask what field the open statements belong to when the programme's vocabulary is removed, and read that field.* Both come out somewhere the record has never looked.

**(A) becomes a cone-positivity question.** $\langle 2(W_+\#W_-)-\theta W_--W_-^2,\ \mathrm{Ric}^*(\mathrm{Ric}(|W|))\rangle\ge0$ is *positivity of one bilinear pairing between two operators built from a curvature operator by the sharp product and by the Ricci adjoint*. That is the Böhm–Wilking cone machinery and the algebraic-curvature-operator literature, and the record uses it only through the identity $A\#B\succeq0$ for $A,B\succeq0$.

**(B) becomes a quantitative-stability question, and it is not a curvature question at all.** *Granting (A), every critical point clearing the threshold has scalar curvature above a bound or defect above one; comparing the two regimes closes it, in a window of width $0.011$.* Stripped of the geometry: **a sharp inequality with two competing near-extremal families, and a deficit that must control the distance to the extremal set.** That is the *stability of extremal problems* literature (Bianchi–Egnell in shape, Figalli–Zhang in method) which this record has never read.

**Searched.** `Kulkarni–Nomizu sharp product positivity curvature operator Lambda^2 pairing inequality`; `quantitative stability deficit inequality extremal spectral problem sharp rigidity almost-maximizers`.

**What came back, and what it is worth.**

- **Nothing on (A).** The Kulkarni–Nomizu results returned are definitional or about PIC cones under 2-positivity, the record's own ground. *No source pairs a sharp product against a Ricci adjoint.*
- **On (B), a field rather than a paper**, which is the useful outcome. Quantitative stability has a standing shape: *deficit controls distance to the extremal set, with a sharp exponent*, and its recent machinery for **two competing families** is the multi-bubble literature, [sharp multi-bubble stability for fractional Hardy–Sobolev](https://arxiv.org/html/2512.18350), and [sharp gradient stability for Sobolev](https://people.math.ethz.ch/~afigalli/papers-pdf/Sharp-gradient-stability-for-the-Sobolev-inequality.pdf). **The two-regime comparison is a two-bubble problem**: $S^{n/2}\times S^{n/2}$ and the $\mathbb{CP}^2$-type competitor are the two bubbles, the defect $\delta^2$ is the deficit, and $\kappa_n$ is the sharp constant the literature computes rather than posits.
- Also returned: [spectral gap as the quantitative mechanism](https://arxiv.org/html/2605.25453v1) for stability estimates, *which is the mechanism [I20](../plan.md) needed and could not find, and it is standard there.*

**The read on it.** *This does not hand the programme a theorem.* What it hands over is that **[Conjecture L16](../findings/problem.md) is a stability statement in the technical sense**, its $\kappa_n$ pinned by requiring equality at the second bubble (exactly how a multi-bubble constant is pinned) and that the field has a standard method for the comparison the record calls its open core. **Nothing in [references/](../references/) is from that field.**

**Owed before this is a route**: read one multi-bubble stability proof end to end and say what its comparison step needs, against what [Lemma L18](../findings/problem.md)'s chain supplies.

## Batch 2, one multi-bubble stability proof, read end to end

**Source**: [sharp multi-bubble stability for fractional Hardy–Sobolev](https://arxiv.org/html/2512.18350). Read for its *comparison step*, which is what [Conjecture L16](../findings/problem.md)'s open core needs.

**Its four load-bearing parts, and what each says about the record.**

> **(i) There is no dichotomy.** The proof does **not** split into two regimes and compare them. It builds a family of cutoffs $\Phi_i$ with bubble $V_i$ dominating on $\{\Phi_i>0\}$ and negligible on $\{\Phi_i<1\}$, *a scale-adaptive partition*, with distinct scales separated by annuli of controlled width. **The two-regime comparison [Lemma L18](../findings/problem.md)'s chain reaches for is not how this field closes such a statement**, and the record has been trying to do by comparison what the literature does by partition.
>
> **(ii) The spectral gap is the engine, and it is a *weighted* one.** For $\rho$ orthogonal to the tangent space $\mathrm{span}\{V_i,\dot V_i\}$, a weighted inequality with constant $C<1$ **coming from the second eigenvalue of the linearised operator, with the first two eigenfunctions excluded**, scaling and translation. *That is [Lemma L128](../findings/second-order.md)'s structure exactly: the orbit directions are the excluded eigenfunctions, and the clause is that nothing else reaches the threshold.* **The programme has the object; what it lacks is the weight.**
>
> **(iii) The sharp constant is computed, not posited.** It balances the spectral-gap ratio, the nonlinear remainder, and the **bubble–bubble interaction integrals**, which scale as $O(\delta^{(N-2s)/2})$. *The record's $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ is pinned by requiring equality at the competitor, the same role, obtained by fiat rather than by balance.* **A balance computation would say whether $\kappa_n$ is the right constant or merely a consistent one.**
>
> **(iv) The dimension restriction is a Taylor-remainder fact.** The proof needs $p>2$, where $(a+b)^p$ carries a quadratic remainder controllable by Hölder; at $p\le2$ that term vanishes and **new eigenvalue resonances prevent a uniform linear estimate**. *The record's own $n\ge12$ is a threshold of the same kind, and the parallel is worth testing rather than assuming.*

**The read.** The useful import is **(i) and (ii)**, and they point the same way: *replace the two-regime comparison with a partition, and make the spectral gap weighted.* The record's [post F47](../findings/INDEX-traps.md)–F54 all fence attempts to bound one global quantity; **a partition argument bounds different things in different places, which is a class no post touches.**

**What this is not.** No theorem transfers, the setting is a fractional Sobolev problem on $\mathbb R^N$, not a cubic on a compact sphere of tensors, and the bubbles there are non-compact scaling families while here they are $O(n)$-orbits. *The transfer is of method, and the first thing it needs is the analogue of the scale parameter $\lambda_i$: this problem's bubbles are compact, so what plays the role of scale separation is not obvious and may not exist.*

**Owed**: whether an $O(n)$-orbit family admits a partition of the kind (i) builds, given that the two competitors sit at fixed distance rather than at separating scales.

## Batch 3, does the method survive without a scale parameter?

**The question batch 2 left**: the partition of (i) separates bubbles *by scale*, and this problem's two competitors sit at fixed distance on a compact sphere of tensors. Searched: `stability sharp inequality compact manifold two competing extremizers no scale parameter Lojasiewicz partition`.

**Two answers, and they point in opposite directions.**

> **The compact case exists and behaves differently.** [Stability of Sobolev inequalities under Ricci lower bounds](https://arxiv.org/pdf/2210.00636): with positive Ricci, *an almost-extremal function is close to an extremal function of the round sphere*, **a stability statement on a compact space with no scaling family**, which is the geometry this problem has. *So the field does not require a scale parameter; the fractional paper's partition is one technique inside it, not the field's shape.*
>
> **And where two extremizers genuinely compete, the resolution is a compactness threshold rather than a comparison.** [Optimizers for the sharp stability constant in log-Sobolev](https://arxiv.org/pdf/2606.23225): sequences *split asymptotically into two non-interacting bubbles*, and existence follows from **distinct compactness thresholds, one per scenario**, not from comparing the two regimes' values. **That is the same move as the partition and it needs no scales: each scenario gets its own threshold, and the argument never puts the two side by side.**

**What this settles about the record.** [Conjecture L16](../findings/problem.md)'s open core (*comparing the scalar-large and defect-large regimes*), **is the one step this field consistently avoids**, in both a scaling setting and a compact one. Two independent sources resolve the same difficulty by giving each regime its own criterion instead. *The record's own note that "nothing lossy will finish it" is consistent with that: a comparison in a window of width $0.011$ is lossy by construction, and the literature's answer is not to sharpen it but to not perform it.*

**And [Łojasiewicz](https://perso.imj-prg.fr/alix-deruelle/wp-content/uploads/deruelle-pub/Lojasiewicz-ALE/ALE-Ric-flat-sing.pdf) is the third mechanism**, for exactly this shape: a functional near a degenerate critical manifold, with the inequality supplying the rate. *[Lemma L128](../findings/second-order.md)'s isolation and the $\mathfrak{su}(m)$ degenerate points are that setting, and the record has no Łojasiewicz statement anywhere.*

**Searched, cumulative**: three queries this pass. **Filed as sources: none yet**, the reading is of methods, and a `notes.md` is owed only once one of them is taken up.

## Batch 4, Łojasiewicz, and why it is the mechanism this problem already satisfies the hypotheses for

**Searched**: `Lojasiewicz inequality analytic functional compact group orbit degenerate critical manifold gradient inequality finite dimensional`.

**The hypotheses, against what this problem has.**

| the inequality needs | this problem |
|---|---|
| a real-**analytic** functional | $P(W)=\langle W,W^2+W^\#\rangle$ is a **cubic polynomial**, analytic outright |
| a compact domain | the unit sphere of $\mathcal W_n$, finite-dimensional |
| no convexity | none available, and none needed |
| it handles **degenerate** critical points | the $\mathfrak{su}(m)$ family and the plateau, kernel excesses to $20$ |

**And the exponent is known in the two cases the record can name.** $\theta=\tfrac12$ *when the Hessian is invertible* (a consequence of the Morse lemma) and near a **Morse–Bott** critical manifold the functional is a sum of squared terms, which is [Lemma L128](../findings/second-order.md)(ii)'s conclusion exactly. *So at every point where L128's block criterion holds, the Łojasiewicz exponent is $\tfrac12$ and the inequality is not a hypothesis but a corollary.*

**Why this matters for the open core.** A Łojasiewicz inequality *"regulates the flatness of analytic energies around critical points by the energy level"*, **it converts a value gap into a distance, which is exactly what [I20](../plan.md) was, and exactly what the record could not supply.** I20 was closed because its constant could not be bounded below; *the Łojasiewicz route does not bound that constant, it asserts the inequality with an exponent and gets the constant from analyticity.*

**The honest caveat, stated before this is called a route.** Łojasiewicz gives $\lvert P(W)-P(W_c)\rvert^{\theta}\le C\lVert\nabla P(W)\rVert$ **near a given critical point**, with $C$ and a neighbourhood depending on that point. *Turning that into a statement over the whole band needs uniformity across the critical set, and compactness gives a finite subcover only if the critical set is compact*, which [Lemma L128](../findings/second-order.md)(iv) supplies **on the pure locus** and which the non-pure side does not yet have.

**Sources**: [Łojasiewicz–Simon in Hilbert spaces](https://www.sciencedirect.com/science/article/pii/S0022123602001027), [gradient flow in Morse and analytic settings](https://arxiv.org/pdf/2311.09968), [the encyclopedia entry](https://encyclopediaofmath.org/wiki/Lojasiewicz_inequality). **Nothing in [references/](../references/) is from this literature**, and the programme has used no Łojasiewicz statement anywhere.

## Batch 5, statement (A), searched in the field it belongs to

**Searched**: `Bohm Wilking curvature operator cone pinching sharp product Ric* adjoint bilinear pairing positivity 2024 2025`. The intent was the machinery around $\langle 2(W_+\#W_-)-\theta W_--W_-^2,\ \mathrm{Ric}^*(\mathrm{Ric}(|W|))\rangle\ge0$, not the record's block calculus.

**What the field has, and it is a family the record uses only one member of.** Böhm–Wilking's linear map
$$\ell_{a,b}(R)=R+b\,\mathrm{Ric}(R)\wedge\mathrm{id}+\tfrac1n(a-b)\,\mathrm{scal}(R)\,\mathrm{id}\wedge\mathrm{id},$$
with an identity for **how $Q(R)=R^2+R^\#$ transforms under it**. *That is a two-parameter family of substitutions under which the record's own $Q$ has a known transformation law, and the programme uses $\mathrm{Ric}(R)\wedge\mathrm{id}$ only as the fixed object $H$, never as the $b$-direction of a family it can move along.*

**Why that is the right shape for (A).** The open statement pairs $Q$'s two pieces against $\mathrm{Ric}^*(\mathrm{Ric}(|W|))=\mathrm{Ric}(|W|)\wedge2\,\mathrm{id}$, **which is $\ell_{a,b}$'s middle term at $b=1$.** So the pairing to be signed is a directional derivative of $Q$ along the family, and the transformation identity is exactly the tool for signing such a thing. *The record derived $H=h\wedge2\,\mathrm{id}$ independently and never connected it to $\ell_{a,b}$.*

**Live sources, all outside [references/](../references/)**: [pinching cones for PIC in dimensions seven and eight](https://arxiv.org/html/2608.26598), [PIC in dimension at least nine](https://arxiv.org/pdf/2410.21078), [noncoercive Ricci-flow-invariant curvature cones](https://arxiv.org/pdf/1308.1190), and [sharp Weitzenböck and PIC2 estimates from sectional-scalar pinching](https://arxiv.org/html/2607.18216).

**The read, stated at its true strength.** *No source states (A) or anything equivalent*, this is a route to a tool, not a hit. **What it changes is the object to reach for**: not another bound on $\langle X_{\mathrm{inv}},H\rangle$, which [post F54](../findings/INDEX-traps.md) fences, but the transformation law for $Q$ under $\ell_{a,b}$, evaluated at $b=1$. *Whether the record's $X_{\mathrm{inv}}$ is that derivative is a calculation, and it is the first thing owed.*

## Batch 6, the tool batch 5 pointed at is already in `references/`, unused

**Screened first**: `ell_{a,b}` and the $Q$-transformation law appear **nowhere** in [findings/](../findings/), [ATTEMPTS.md](../ATTEMPTS.md) or any `notes.md`. But reading [boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md) for the family turned up its **Lemma 2.1**, transcribed in the record and never used:
$$R+R\,\#\,I=(n-1)R_I+\tfrac{n-2}2R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}.$$

**Which collapses statement (A) into the $\#$-calculus.** The record's $H=\mathrm{Ric}(|W|)\wedge2\,\mathrm{id}$ is, by bilinearity of $\wedge$, twice $\mathrm{Ric}(|W|)\wedge\mathrm{id}$, and Lemma 2.1 says that is $\lvert W\rvert+\lvert W\rvert\,\#\,I$. So
$$\boxed{\ H\;=\;2\big(\lvert W\rvert+\lvert W\rvert\,\#\,I\big)\ }$$
**and the open pairing $\langle X_{\mathrm{inv}},H\rangle\ge0$ becomes a statement with no Ricci adjoint in it at all**, both arguments are built from $\lvert W\rvert$, $W_\pm$ and $\#$, which is the one calculus this programme has in depth.

**Why this is worth more than the batch-5 pointer.** [Post F54](../findings/INDEX-traps.md) fences *re-bounding $H$ by trace data*; it says nothing about **rewriting $H$ so that no bounding of it is needed**. *And the record's own derivation of $H$'s spectrum as $\{h_i+h_j\}$ is a special case of Lemma 2.1 read spectrally, the same fact, reached twice, joined here for the first time.*

**Owed before this is used, and it is one check.** The factor and the argument: Lemma 2.1 is stated for a general algebraic curvature operator $R$ with $\mathrm{Ric}$ *its own* Ricci, so the substitution needs $R=\lvert W\rvert$ and $\mathrm{Ric}(\lvert W\rvert)$ to be that operator's Ricci in the same normalisation. **If it survives, statement (A) is $\langle 4(W_+\#W_-)-2\theta W_--2W_-^2,\ \lvert W\rvert+\lvert W\rvert\#I\rangle\ge0$**, a single $\#$-calculus inequality, and the first form of the grant with no Ricci in it.

**Sources**: already held. *The sweep's own justification, that the record's vocabulary hides what it holds, applies to `references/` as much as to `findings/`.*

## Phase 3, the routes, screened by mechanism against the fence posts

*Screened first against [INDEX-traps.md](../findings/INDEX-traps.md)'s table by mechanism, then by expression, the order the rule now requires.*

### Route 1, statement (A) inside the $\#$-calculus *(my pick)*

- **Mechanism.** [Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md) rewrites $H$ as $2(\lvert W\rvert+\lvert W\rvert\#I)$, turning the $J_5$ grant into $\langle 4(W_+\#W_-)-2\theta W_--2W_-^2,\ \lvert W\rvert+\lvert W\rvert\#I\rangle\ge0$, **one inequality, no Ricci, no blocks, no frames.**
- **What it delivers.** [Conjecture L16](../findings/problem.md)'s first owed step, in the calculus with the most machinery behind it: $A\#B\succeq0$ for $A,B\succeq0$, the $\#$-block formulas, $\operatorname{tr}W^\#=-1$, $\lvert W\rvert^\#=W^\#+4W_+\#W_-$.
- **What it takes.** One normalisation check on Lemma 2.1's substitution, then the inequality itself.
- **Falsifier.** The substitution failing, the lemma's $\mathrm{Ric}$ being the operator's own rather than $\mathrm{Ric}(\lvert W\rvert)$ in this normalisation. *Checkable by hand at padded $W_{\mathbb{CP}^2}$.*
- **Screened.** [Post F54](../findings/INDEX-traps.md) fences *re-bounding $H$ by trace data*; this **rewrites** $H$ so no bound on it is needed. F51's rearrangement fence is about the pair-clause data, a different object. **Clear.**

### Route 2, Łojasiewicz, and the constant I20 could not get

- **Mechanism.** $P$ is a cubic polynomial on a compact sphere, so the Łojasiewicz inequality applies with no extra hypothesis, and near a Morse–Bott critical manifold the exponent is $\tfrac12$, which is [Lemma L128](../findings/second-order.md)(ii)'s conclusion. **It converts a value gap into a distance**, which is what [I20](../plan.md) needed.
- **What it delivers.** The deficit inequality I20 was closed for lacking, with the constant coming from analyticity rather than from a bound nobody could prove.
- **What it takes.** Uniformity across the band: the local inequality plus a compact critical set. [Lemma L128](../findings/second-order.md)(iv) supplies compactness on the pure locus; the non-pure side does not have it.
- **Falsifier.** The non-pure critical set failing to be compact, or the exponent degenerating at the $\mathfrak{su}(m)$ points.
- **Screened.** I20 was closed as *true and useless* because $c_n$ could not be bounded **below**, a different mechanism, since Łojasiewicz does not bound that constant but supplies one. **Clear, and it reopens a closed item honestly.**

### Route 3, replace the two-regime comparison with a partition

- **Mechanism.** Two independent literatures resolve competing near-extremal families **without comparing them**: a scale-adaptive partition, or a compactness threshold per scenario. [Conjecture L16](../findings/problem.md)'s open core is exactly a comparison, in a window of width $0.011$.
- **What it delivers.** The chain's closure, by the route the field actually uses.
- **What it takes.** An analogue of scale separation for two $O(n)$-orbits at fixed distance, *which may not exist*, and is the first thing to settle.
- **Falsifier.** No partition exists for compact orbit families at fixed distance.
- **Screened.** Every post fencing this item fences bounds on **one global quantity**; a partition bounds different things in different places. **Clear, and it is the class no post touches.**

### Route 4, the $\ell_{a,b}$ transformation law

Held in reserve behind Route 1, which reaches the same object more cheaply. *If the Lemma 2.1 substitution fails, this is where the same idea survives: $Q$'s transformation law under $\ell_{a,b}$, evaluated at $b=1$.*

**Recommendation: Route 1**, with Route 2 next. Route 1 is one check away from being usable, is analytical throughout, and lands on the grant that [R17](../routes.md) (the only unfenced route to the goal), owes first. **Route 3 is the deepest and the least concrete; it should wait until Route 1 settles whether the grant closes at all.**

## Route 1, first check, the falsifier fires, and the repair is in the conjecture's own currency

**The check owed was whether Lemma 2.1 applies at $R=\lvert W\rvert$. It does not.** The lemma is stated for $R\in S^2_B(\mathfrak{so}(n))$ (**Bianchi** operators) and the record's own Result 3 says *"$\lvert W\rvert$ is Bianchi exactly when $\delta=0$"*. **So the substitution is valid precisely on the zero-defect locus and nowhere else.**

**Which is not a dead route but a priced one, in the currency the conjecture already uses.** $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ is the failure of $\lvert W\rvert$ to be Bianchi, and it is **the same scalar [Conjecture L16](../findings/problem.md) is written in**. So the rewrite reads
$$H\;=\;2\big(\lvert W\rvert+\lvert W\rvert\,\#\,I\big)\;+\;(\text{a correction vanishing with }\delta),$$
and the record **already prices corrections of exactly this shape**: Result 2's identity $D(R)=\tfrac32\sum\mathrm{Alt}(R)\mathrm{Alt}(R)$, proven twice, PSD, with $\operatorname{tr}D=6\lVert\mathrm{Alt}R\rVert^2$.

**What the check has bought.** *Route 1 is not one inequality but two*: the $\#$-calculus statement on the Bianchi locus, plus a correction whose size is $O(\delta^2)$ and whose calculus the chain already carries. **And that is the same shape as the chain's other two corrections** ($J_4$'s Bianchi penalty and the $\tfrac32$-Gram), *so the grant would join them rather than sit outside.*

**Owed next**: the correction term explicitly, i.e. $\mathrm{Ric}(R)\wedge\mathrm{id}-(R+R\#I)$ for non-Bianchi $R$, which Lemma 2.1's proof gives by tracking where Bianchi enters. **Screened**: nothing in [findings/](../findings/) or [INDEX-traps.md](../findings/INDEX-traps.md) carries that expression.

*Recorded as a check that fired, not as a closure: the route survives, at a price the conjecture was already paying.*
