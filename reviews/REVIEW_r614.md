# Review r614, Lemma L119, the sharpened $\lambda$-weighted bound $\theta\le[\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta]/4$

**Verdict: CONFIRMED as an inequality, and both improvement claims are proved.** The identity $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$, the split $4\theta=A-B$, the two discards, the constant $4$ and the placement of $\lvert\lambda_{\min}\rvert$ and $\lambda^{\min}_{\mathfrak p}$ are all correct; *never weaker* and *strictly stronger wherever $\Delta>0$* both hold with no exceptional points. **The $C_5$ recovery is not a coincidence, it is derivable in closed form and is derived below by hand.** Against that, the block carries **six defects**, one of them a flat statement of fact that the same file refutes ten lines above it, and one a load-bearing hypothesis the block drops in the very sentence where it widens the hypothesis set.

Reviewer B of an independent pair, working the identical brief. **Analysis only: nothing below was computed.** Every number, $\lambda_{\min}$, $\lambda^{\min}_{\mathfrak p}$, $M=24$, $\Delta=12$, $0.894427$, $0.670820$, is derived in closed form from the $C_5$ blow-up's recorded entries and checked against three figures the record already holds.

---

## 1. The identity $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$, CONFIRMED, and what it consumes

Derived cold. Write $\{v_\gamma\}$ for a $W$-eigenbasis of $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, orthonormal under the half-trace pairing of [conventions.md](../findings/conventions.md), $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ and $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$, totally symmetric.

**Step 1, the density.** $(\mathrm{ad}\,v_\gamma)_{\alpha\beta}=c_{\gamma\beta\alpha}$ and $W$ is diagonal, so $[\mathrm{ad}(v_\gamma),W]_{\alpha\beta}=(\lambda_\beta-\lambda_\alpha)c_{\gamma\beta\alpha}$ and

$$g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\alpha\beta\gamma},$$

which is [Petersen–Wink Prop 1.7](../references/petersen-wink-2019-bochner-technique/notes.md) and needs only that $\{v_\gamma\}$ is an eigenbasis.

**Step 2, expand and use total symmetry.** $(\lambda_\alpha-\lambda_\beta)^2=\lambda_\alpha^2+\lambda_\beta^2-2\lambda_\alpha\lambda_\beta$, and the $\alpha^2$ and $\beta^2$ terms are equal by the $\alpha\leftrightarrow\beta$ symmetry of $T$, so

$$\sum_\gamma\lambda_\gamma g_\gamma=2S_1-2S_2,\qquad S_1=\sum_{\alpha\beta\gamma}\lambda_\alpha^2\lambda_\gamma T_{\alpha\beta\gamma},\qquad S_2=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}.$$

**Step 3, collapse each.** The weight $\lambda_\alpha^2$ sits outside the $(\beta,\gamma)$ sum, so relation (B), $\sum_{\beta\gamma}T_{\alpha\beta\gamma}\lambda_\gamma=-2\lambda_\alpha$, the per-row form of $A(W)=2W$ recorded at [bounds-relaxations.md:118](../findings/bounds-relaxations.md), gives $S_1=-2\sum_\alpha\lambda_\alpha^3=-2\langle W,W^2\rangle$. Relation (C) ($\sum_{\alpha\beta}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta=2(W^\#)_{\gamma\gamma}$), gives $S_2=2\langle W,W^\#\rangle$. Hence

$$\sum_\gamma\lambda_\gamma g_\gamma=-4\langle W,W^2+W^\#\rangle=-4\,P(W).$$

**Cross-check, by the same route.** $\sum_\gamma g_\gamma=2\cdot2(n-2)\lVert W\rVert^2-4\mathop{\mathrm{tr}}(W^\#)=4(n-2)\lVert W\rVert^2+4\lVert W\rVert^2=4(n-1)\lVert W\rVert^2$, using the row marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ and $\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert^2$. That reproduces the record's $4(n-1)$ and confirms the normalisation the whole block runs in.

**It is an identity, and the block is right that criticality is not consumed.** What it consumes is: total antisymmetry of $c$ (hence total symmetry of $T$), relations (B) and (C) (that is, $W\in\mathrm{Weyl}_n$, first Bianchi and trace-freeness) and **nothing else**. The block's "*it is not a criticality statement … the sharpened bound is valid at every Weyl tensor*" is CONFIRMED, and it is now proved rather than measured at ten points.

> ### DEFECT 1, the unit-norm hypothesis is dropped, in the sentence that widens the hypothesis set
>
> The identity is $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$, and $-4\theta$ only at $\lVert W\rVert=1$. Under $W\mapsto sW$: $\theta$ is scale-invariant (degree $0$), while $\lvert\lambda_{\min}\rvert$ scales as $s$ and $g$, $\Delta$, $G_0$, $M$ as $s^2$, so the displayed right-hand side scales as $s^3$. **At any $W$ with $\theta>0$ the bound fails for $s$ small enough.** The block strikes criticality and announces the widened scope in the same clause; that is exactly where the remaining hypothesis needed saying, and it is said nowhere in the block.

> ### DEFECT 2, the identity is Petersen–Wink Prop 1.3, and the same file says so 188 lines above
>
> [bounds-relaxations.md:118](../findings/bounds-relaxations.md) already names it: *"[Petersen–Wink 2105.09290](../references/petersen-wink-2021-tachibana-special-holonomy/) Prop 1.3 states exactly this contraction … whose value here is $-4\theta$."* The reference's own notes go further, *"Any bound this project derives by isolating $\lambda_{\min}$ in that sum is a re-use of their technique and is cited as such"*, and the $A\le\lvert\lambda_{\min}\rvert M$ step is precisely that isolation. **L119 cites a project script and no source.**

---

## 2. The split, the two discards, and the constant, CONFIRMED

With $\mathfrak m=\mathrm{span}\{v_\gamma:\lambda_\gamma<0\}$ and $\mathfrak p=\mathrm{span}\{v_\gamma:\lambda_\gamma>0\}$, the definitions at [curvature-invariants.md:85](../findings/curvature-invariants.md), where $\Delta:=\sum_{\gamma\in\mathfrak p}g_\gamma$ is also fixed, the three-way split of $-4\theta=\sum_\gamma\lambda_\gamma g_\gamma$ is

$$-4\theta=-\underbrace{\sum_{\mathfrak m}\lvert\lambda_\gamma\rvert g_\gamma}_{A}+\underbrace{\sum_{\mathfrak p}\lambda_\gamma g_\gamma}_{B}+0,\qquad\text{i.e.}\qquad 4\theta=A-B,$$

the kernel contributing nothing because $\lambda_\gamma=0$ there. **The block's $4\theta=A-B$ is correct.**

**The two discards, with the sign named at each.**

| step | inequality | direction | why it is legitimate |
|---|---|---|---|
| on $A$ | $A\le\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma=\lvert\lambda_{\min}\rvert M$ | **raises** the right-hand side | $\lvert\lambda_\gamma\rvert\le\lvert\lambda_{\min}\rvert$ on $\mathfrak m$, $g_\gamma\ge0$ |
| on $B$ | $B\ge\lambda^{\min}_{\mathfrak p}\sum_{\mathfrak p}g_\gamma=\lambda^{\min}_{\mathfrak p}\Delta$ | **raises** $-B$, hence the right-hand side | $\lambda_\gamma\ge\lambda^{\min}_{\mathfrak p}>0$ on $\mathfrak p$, $g_\gamma\ge0$ |

Both move the bound the same way, which is the only combination that composes. $4\theta=A-B\le\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta$, and dividing by $4$ gives the claim. **The constant $4$ is correct**, it comes from the identity's own $-4$, nowhere else.

**$M$ is the $\mathfrak m$-mass and the arithmetic checks.** $M:=4(n-1)-\Delta-G_0=\sum_\gamma g_\gamma-\sum_{\mathfrak p}g_\gamma-\sum_{\ker}g_\gamma=\sum_{\mathfrak m}g_\gamma$, so the two occurrences of $\Delta$ in the displayed bound are genuinely different objects, one is the removed $\mathfrak p$-mass inside $M$, the other the mass restored with a weight. That is what makes the sharpening non-circular.

**$-\lambda^{\min}_{\mathfrak p}\Delta$ is a genuine subtraction, not an addition in disguise.** $\lambda^{\min}_{\mathfrak p}=\min\{\lambda_\gamma:\lambda_\gamma>0\}>0$ strictly, and $\Delta\ge0$, so the term is $\le0$ with no sign case to check. **This depends entirely on $\mathfrak p$ being the *strictly* positive eigenspace with $\ker W$ split off separately.** Had $\mathfrak p$ been $\{\lambda\ge0\}$, then $\lambda^{\min}_{\mathfrak p}=0$ at every kernel-carrying point and the sharpening would be inert at padded $W_{\mathbb{CP}^2}$, padded $S^3\times S^3$ and every other padded point on the record. The block asserts the strict reading in passing (*"since $\lambda_\gamma>0$ strictly on $\mathfrak p$"*) and never cites where the splitting is defined.

> ### DEFECT 3, the splitting is used uncited, and its own file's tabled sense makes the identity false
>
> [conventions.md](../findings/conventions.md) tables $\mathfrak m=E_{\min}$ and warns that $\mathfrak m$ *"carries three incompatible senses across the record … so read it from context"*. **Under the tabled sense $4\theta=A-B$ is false**, because $\mathfrak m\cup\mathfrak p\cup\ker$ then fails to exhaust the index set at any $W$ with two distinct negative eigenvalues, and the terms in the gap are dropped silently. The sense L119 needs is the second one, and it is defined at [curvature-invariants.md:85](../findings/curvature-invariants.md), a file the block does not cite. **The mathematics is right; the reader has no way to know which of three senses to read it in.**

> ### DEFECT 4, the bare $M$ in the heading, and it has propagated to the index
>
> The block heading and [INDEX-results.md](../findings/INDEX-results.md) row 119 both carry $\theta\le[\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta]/4$ with no definition of $M$ attached. [conventions.md](../findings/conventions.md) tables $M$ as **the global maximum of $P$ on the unit sphere**, $M(n)\ge\sqrt{3/2}$, and separately as the $n\times n$ sectional matrix. Read at the index (which is where a citing block will read it), the headline formula is a different and false statement. The definition appears only inside the displayed equation four lines into the block. *The heading was placed by `c14052fc`, "place headings for Lemmas L107–L119", the same bulk commit [LEDGER.md](../findings/LEDGER.md) already records for mislabelling [L117](../findings/bounds.md).*

---

## 3. "Never weaker, strictly stronger wherever $\Delta>0$", both PROVED

**Never weaker.** As an inequality between right-hand sides at a fixed admissible $W$:

$$\frac{\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta}{4}\ \le\ \frac{\lvert\lambda_{\min}\rvert M}{4}\iff\lambda^{\min}_{\mathfrak p}\Delta\ge0,$$

which holds at every unit $W\in\mathcal W_n$ since both factors are $\ge0$. **No hypothesis, no exceptional point.** CONFIRMED.

**Strictly stronger wherever $\Delta>0$.** Strictness needs $\lambda^{\min}_{\mathfrak p}\Delta>0$, so it needs $\lambda^{\min}_{\mathfrak p}\ne0$, and the brief asks whether that is forced. **It is, and twice over.** First, $\lambda^{\min}_{\mathfrak p}>0$ by definition of $\mathfrak p$ as the strictly positive eigenspace. Second, $\mathfrak p\ne\varnothing$ is forced independently: $\mathop{\mathrm{tr}}W=0$ with $W\ne0$ requires a strictly positive eigenvalue, so the minimum is over a non-empty set at every admissible $W$. And $\Delta>0$ already implies $\mathfrak p\ne\varnothing$ on its own, $\Delta$ being a sum over $\mathfrak p$. **So there are no $\Delta>0$ points where the two bounds coincide, and the claim survives as quantified.** CONFIRMED.

**A free strengthening the block leaves on the table.** $\lambda^{\min}_{\mathfrak p}$ may be attained at a direction carrying $g_\gamma=0$, which contributes nothing to $\Delta$ but caps the whole gain. The step is equally valid with $\lambda^{\min}_{\mathfrak p,g}:=\min\{\lambda_\gamma:\lambda_\gamma>0,\ g_\gamma>0\}\ge\lambda^{\min}_{\mathfrak p}$, since only $g_\gamma>0$ terms contribute to either side of $B\ge\lambda\Delta$. That version is never weaker and costs nothing. At the $C_5$ blow-up the two coincide, which is why the point does not expose the difference.

> ### DEFECT 5, the "that is" reinstates a converse the record withdrew
>
> *"strictly stronger wherever $\Delta>0$, **that is**, everywhere in the band not already handed to step **H**"* equates $\{\Delta>0\}$ with $\{$not graded$\}$. **Only one direction is proved.** $\Delta=0\Rightarrow$ graded is the theorem at [bounds.md:108](../findings/bounds.md), so not-graded $\Rightarrow\Delta>0$ and $\{\Delta>0\}\supseteq\{$not handed to H$\}$; the converse is false, and [bounds.md](../findings/bounds.md) carries the witness, a **graded** critical point at $n=8$ with $\Delta=1.512$. [target.md:530](../findings/target.md) withdrew this exact converse in as many words: *"the reason first given here, 'because $\Delta=12>0$', is an **invalid converse** and is withdrawn"*. The sentence's payload (strictly stronger everywhere step H does not reach), is **true** by the inclusion, so this is a wording defect and not a false claim; but it is the withdrawn wording, restated.

---

## 4. The $C_5$ recovery, DERIVED, and it is a fact about that point only

The block reports $0.894427\to0.670820=\theta$ *"exactly"* and offers no derivation, so the brief's question is live. **It is derivable, and here it is derived, by hand, no computation.**

**The point in closed form.** [nondegeneracy.md:383](../findings/nondegeneracy.md) records the $C_5$ blow-up as $n=10$, blocks $(2,2,2,2,2)$, entries in ratio $4:-2:+1$, trivial kernel. Write $p=4c$ for a within-block entry, $q=-2c$ for an entry between $C_5$-adjacent blocks and $r=+c$ for one between non-adjacent blocks. Each vertex has $1$ partner, $4$ adjacent-block neighbours and $4$ non-adjacent ones, so the $\mathcal D_n$ row-sum condition reads $4c-8c+4c=0$, satisfied identically, which is what forces the ratio.

**Normalisation.** The $45$ unordered pairs split $5/20/20$, and on the diagonal locus the $\Lambda^2$ spectrum **is** the multiset of entries ([conventions.md](../findings/conventions.md)), so $\sum\lambda^2=5(4c)^2+20(2c)^2+20c^2=180c^2=1$, giving

$$c=\tfrac1{6\sqrt5},\qquad \lambda_{\min}=-2c=-\tfrac1{3\sqrt5}\ (\text{mult }20),\qquad \lambda^{\min}_{\mathfrak p}=c=\tfrac1{6\sqrt5}\ (\text{mult }20),\qquad \lambda_{\max}=4c\ (\text{mult }5).$$

$\dim\mathfrak m=20$, matching the record's own $\dim\mathfrak m=20$ at [bounds.md:123](../findings/bounds.md). Trace: $5(4c)+20(-2c)+20(c)=0$. ✓

**The three $g$-values, from [Lemma L68](../findings/diagonal-half.md)'s $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$.**

| pair type | $\lVert M_a-M_b\rVert^2$ | $4M_{ab}^2$ | $g_{ab}$ | count | mass |
|---|---|---|---|---|---|
| within a block | $32c^2$ (rows differ **only** on the pair itself, the two vertices are twins) | $64c^2$ | $\mathbf0$ | $5$ | $0$ |
| adjacent blocks | $116c^2$ | $16c^2$ | $216c^2=1.2$ | $20$ | $\mathbf{24}$ |
| non-adjacent blocks | $56c^2$ | $4c^2$ | $108c^2=0.6$ | $20$ | $\mathbf{12}$ |

**Three independent confirmations that this is the right point.** The masses sum to $0+24+12=36=4(n-1)$ ✓. The $\mathfrak p$-mass is $0+12=12$, which is the record's $\Delta=\mathbf{12}$ at [bounds.md:123](../findings/bounds.md) ✓. The $\mathfrak m$-mass is $24=4(n-1)-\Delta-G_0=36-12-0$ ✓.

**The two bounds, exactly.**

$$\frac{\lvert\lambda_{\min}\rvert M}{4}=\frac{\tfrac1{3\sqrt5}\cdot24}{4}=\frac2{\sqrt5}=0.8944272,\qquad \frac{\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta}{4}=\frac{\tfrac8{\sqrt5}-\tfrac2{\sqrt5}}4=\frac3{2\sqrt5}=0.6708204 .$$

And directly $4\theta=A-B=\tfrac8{\sqrt5}-12c=\tfrac6{\sqrt5}$, so $\theta=\tfrac3{2\sqrt5}=0.670820393$, the record's value to every recorded digit. **Both of the block's figures are exact and both are reproduced.**

**So the answer to "derived or measured" is: measured in the block, derivable in four lines, and the mechanism is two structural facts about this point.**

1. **$\mathfrak m$ carries a single eigenvalue** ($-2c$ at multiplicity $20$), so $A=\lvert\lambda_{\min}\rvert M$ **automatically**, the $A$-discard is vacuous here.
2. **The larger positive eigenvalue carries zero $g$-mass**, because same-block vertices are twins: $M_a-M_b$ is supported on $\{a,b\}$ alone, with entries $\mp M_{ab}$, so $\lVert M_a-M_b\rVert^2=2M_{ab}^2$ and $g_{ab}=2\cdot2M_{ab}^2-4M_{ab}^2=0$. So $B=\lambda^{\min}_{\mathfrak p}\Delta$ and the $B$-discard is vacuous too.

**Neither is generic, and neither is claimed to be.** "Recovers all the slack" is an **Observation about one point**, and the block says so, *"the evidence for the size of the improvement rests on one witness … the claim about how much it buys on the band is not [solid]"*. That hedge is honest and it is the right one. **The label `Lemma` attaches to the inequality, which is proved, and not to the size claim, which the block explicitly declines to assert.** On the record's literal-labels rule the block is correctly labelled.

The block's own file supplies the counterweight ten lines above: at the $n=12$ circulant point with $\theta=0.728768$ the sharpened bound gives $1.123155$, slack $0.394$, **so "recovers all the slack" already has a witness against it as a family statement, in the same file.**

> ### DEFECT 6, "$C_5$ is the only catalogued critical point with $\Delta>0$" is FALSE
>
> Refuted **ten lines above in the same file**, where the $\Delta>0$ census reads *"the true figures are $\ge73$ / $\ge61$ / $\ge22$"*, at least $61$ catalogued $\Delta>0$ points, all of which the sharpened bound was tested against. Refuted again by [diagonal-half.md:189](../findings/diagonal-half.md) (*571 diagonal $\Delta>0$ critical points at $n=6\ldots16$*), by [diagonal-half.md:199](../findings/diagonal-half.md) (*66 distinct $\Delta>0$ points*), by [bounds.md:134](../findings/bounds.md)'s graded $n=8$ point at $\Delta=1.512$, and by [REVIEW_r393](REVIEW_r393.md)'s $n=9$ witness at $\Delta=12.07$. The sentence was true of the ten-row table at [bounds.md:123](../findings/bounds.md) when it was written on 2026-08-24; it is false of the record as it now stands. **It matters because it is the stated reason the evidence rests on one witness**, the evidence base is much larger than the block believes, and the honest hedge is resting on a false premise.

---

## 5. A defect that spreads *out* of L119, the equality clause of [Lemma L41](../findings/target.md) is wrong at the padded points

L119 turns on *"$B=0$ exactly when $\Delta=0$ … which is **why** the bound attained equality at all nine $\Delta=0$ points and nowhere else."*

**$B=0\iff\Delta=0$ is correct**, $B$ is a sum of non-negative terms $\lambda_\gamma g_\gamma$ with $\lambda_\gamma>0$, so it vanishes iff every $g_\gamma$ on $\mathfrak p$ does, which is $\Delta=0$. And *"nowhere else"* is correct: equality requires $B=0$, hence $\Delta=0$.

**But "why" is only half the reason.** Equality in the recorded bound needs **both** discards tight:

$$\theta=\tfrac{\lvert\lambda_{\min}\rvert M}4\iff \Delta=0\ \textbf{and}\ g_\gamma=0\text{ for every }\gamma\in\mathfrak m\setminus E_{\min}\iff g\text{ is supported on }E_{\min}\oplus\ker W.$$

$\Delta=0$ alone gives $B=0$ and says nothing about the $A$-side. The correct statement is already in this file, 285 lines above, at [post F28](../findings/bounds-relaxations.md): *"$\Pi-4\theta=0$ needs $\Delta=0$ **and** $g$ carried by the $\lambda_{\min}$ eigenspace within $\mathfrak m$."* **L119 drops the second conjunct**, and post F28's sharpening is L119's own inequality (see §6), so the two blocks are about one object and only one of them states the equality case correctly.

**And the version L119 inherits is itself wrong.** [Lemma L41](../findings/target.md) and [results.md:190](../results.md) both record equality as *"exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace"*. **That is refuted by two of the nine equality points the block names.** Padded $W_{\mathbb{CP}^2}$ at $n=8$ has $G_0=16$ of a total $4(n-1)=28$ (the block's own figure) so at a point where equality **holds**, $57\%$ of the $g$-mass sits in $\ker W$ and not on $E_{\min}$. The kernel mass is already removed inside $M$, so it is free; the condition should read **$g$ supported on $E_{\min}\oplus\ker W$**. *This is L41's defect, not L119's, but L119 is where it is being consumed and it should be fixed at the source.*

---

## 6. Does the block's own file already settle it?, YES, at [post F28](../findings/bounds-relaxations.md), 270 lines above

**The same inequality is already on the file, under different letters.** Post F28 records *"the sharpening $\theta\le[\Pi-\lambda^+_{\min}\Delta]/4$ is valid and **inert**"*. Its $\Pi$ is sense (iii) of [conventions.md](../findings/conventions.md), $\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g$, pinned by F28's own slack identity, since $\sum_{\mathfrak m}(\lvert\lambda_{\min}\rvert-\lvert\lambda_\gamma\rvert)g_\gamma+\sum_{\mathfrak p}\lambda_\gamma g_\gamma=\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma-4\theta$ identically. **And $\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma=\lvert\lambda_{\min}\rvert M$**, while $\lambda^+_{\min}=\lambda^{\min}_{\mathfrak p}$. The two displayed inequalities are the same inequality.

**So the file carries one result twice, with opposite valuations and only one attribution.**

| | post F28, line 42 | Lemma L119, line 312 |
|---|---|---|
| the inequality | $\theta\le[\Pi-\lambda^+_{\min}\Delta]/4$ | $\theta\le[\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta]/4$ |
| valuation | *"valid and **inert**: its gain is $0$ at every $\Delta=0$ point, which is every point that matters"* | *"strictly stronger wherever $\Delta>0$, everywhere in the band not already handed to step **H**"* |
| attribution | [Petersen–Wink Prop 1.3](../references/petersen-wink-2021-tachibana-special-holonomy/notes.md) | a project script |
| entered | `1b8a8b34`, 2026-08-27 | `1c0f1d2b`, 2026-08-24 |

**Both valuations are true statements and they do not contradict** (F28 is scoped to the $\Delta=0$ points, L119 to $\Delta>0$) but "which is every point that matters" and "everywhere in the band" cannot both be the file's position, and the later of the two never mentions the earlier. **The record needs one of these blocks to be a cross-reference to the other.** *This is the checklist item "does the block's own file already settle it", and the answer is that the file settled it three days after L119's substance landed and never told L119.*

---

## 7. Scope, and what it buys

**Hypotheses the *statement* owes**, as against those the proof happens to use:

| owed | status in the block |
|---|---|
| $W\in\mathcal W_n$ (first Bianchi, trace-free) | implicit and correct |
| $\lVert W\rVert=1$ | **absent, and load-bearing**, Defect 1 |
| $\mathfrak m/\mathfrak p$ the strictly negative/positive eigenspaces, $\ker$ split off | asserted once in passing, cited nowhere, Defect 3 |
| criticality | **correctly struck** |
| $n\ge4$, diagonality, gradedness, a spectrum shape | **none needed** |

The splitting is available at every $W$ (a symmetric operator always splits into negative, positive and kernel eigenspaces) so **the bound holds at every $n$ and at every unit Weyl tensor**, with no locus restriction. The block's widening is right.

**What it buys, and there is an analytic cap the record does not carry.** The gain over the recorded bound is exactly $\lambda^{\min}_{\mathfrak p}\Delta/4$, so it is governed by the **smallest positive eigenvalue**, the least robust statistic in the spectrum. Since $\dim\mathfrak p\cdot(\lambda^{\min}_{\mathfrak p})^2\le\sum_{\mathfrak p}\lambda_\gamma^2\le1$,

$$\text{gain}\ \le\ \frac{\Delta}{4\sqrt{\dim\mathfrak p}}\ \le\ \frac{n-1}{\sqrt{\dim\mathfrak p}},$$

**with the first inequality tight only when $\mathfrak p$'s spectrum is flat.** At a generic point $\dim\mathfrak p=\Theta(n^2)$ and the positive eigenvalues are spread, so $\lambda^{\min}_{\mathfrak p}$ is far below its cap and the gain decays; the sharpening is large only on **coarsely degenerate** spectra. That is exactly the $C_5$ blow-up's situation ($\mathfrak p$ carries two values, at multiplicities $20$ and $5$) and exactly what the band's non-diagonal half is not known to give. *This is a sharper statement than "rests on one witness" and it is available with no computation.*

**And the sharpening addresses the smaller half of the slack.** By post F28's identity the total slack splits as $\sum_{\mathfrak m}(\lvert\lambda_{\min}\rvert-\lvert\lambda_\gamma\rvert)g_\gamma+B$. L119 recovers the second summand in full and touches the first not at all. At a generic point most negative eigenvalues sit far from $\lambda_{\min}$, so the first summand dominates, which is why the block's own random-point slack of $1.2$–$1.4$ survives the sharpening nearly intact. **The uncontrolled quantity remains $\lvert\lambda_{\min}\rvert$, as the block says.**

**On $\Theta_n$, the block is CLEAN.** It never names $\Theta_n$; it names $\sqrt{3/2}=1.224745$ and $\theta_0(12)$. Its one parity-sensitive claim is *"at the balanced product the bound returns $1.236033=\theta_0(12)$ exactly"*, and $n=12$ is **even**, where $\Theta_n=\theta_0(n)=\sqrt{2\cdot11\cdot10}/12=1.236033$ ✓. **No conflation of $\Theta_n$ with $\theta_0(n)$ anywhere in the block**, and no odd-$n$ claim to get wrong.

---

## 8. Provenance and pointers

**The provenance note is TRUE.** The block reads *"From findings/target.md … Re-filed here 2026-09-02 from [target.md](../findings/target.md) by the parallel sort"*. `227616f7` (2026-09-02) is *"refactor(findings): sort target.md, 9 KB re-filed"*, whose body reads *"the sharpened $\lambda$-weighted bound, its circulant band witnesses and the tree reproduction move verbatim to findings/\_moves/target--to--bounds.md; canonical Lemma 41 stays here"*, the claim, verbatim, including the reason. It then reached this file through `56601517` and `2d66938e`. **Checked, and clean.** The substance predates the move: `1c0f1d2b`, 2026-08-24, *"the bound's discarded term IS the Delta term"*.

**Pointers.** Both script paths resolve, [b_sharpened_lambda_bound.py](../scripts/route-b/b_sharpened_lambda_bound.py) and [b_lambda_weighted_bound.py](../scripts/route-b/b_lambda_weighted_bound.py). *Not re-run: analysis only.* The block carries no other links; the missing ones, to [curvature-invariants.md](../findings/curvature-invariants.md) for the splitting, to [post F28](../findings/bounds-relaxations.md) for the duplicate, to [Petersen–Wink](../references/petersen-wink-2021-tachibana-special-holonomy/notes.md) for the manoeuvre, are Defects 2, 3 and 6.

**One structural note, outside my remit.** L119 has no row in [results.md](../results.md); neither do L110, L114, L115 or L116 from the same file. That is a file-wide gap for [structure-check](../.claude/skills/structure-check/SKILL.md), not an L119 defect.

---

## What the record may cite

- **The inequality $\theta\le[\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta]/4$, with $M=4(n-1)-\Delta-G_0$: CITABLE**, at every unit-norm $W\in\mathcal W_n$, criticality-free, with $\lVert W\rVert=1$ stated and $M$ defined at every occurrence.
- **"Never weaker": CITABLE**, proved.
- **"Strictly stronger wherever $\Delta>0$": CITABLE**, proved, with no exceptional points.
- **"Recovers all the slack at the $C_5$ blow-up": CITABLE and now DERIVED**, §4 above, in closed form, with the mechanism named. It is a statement about that point.
- **"$C_5$ is the only catalogued critical point with $\Delta>0$": NOT CITABLE**, false.
- **The equality clause "$g$ supported on the $\lambda_{\min}$ eigenspace": NOT CITABLE** as written; the padded points refute it. Read it as $E_{\min}\oplus\ker W$.
- **Anything about how much the sharpening buys on the band: NOT CITABLE.** The gain is capped by $\Delta/(4\sqrt{\dim\mathfrak p})$ and nothing on the record bounds $\lambda^{\min}_{\mathfrak p}$ below.

**Nothing here needs computation to settle.** Every defect above is decided by an argument or by a document already on the record.
