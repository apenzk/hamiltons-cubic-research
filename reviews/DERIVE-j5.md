# DERIVE-j5, the grant $J_5\ge0$: the position, the four fences, and what a new idea must clear

> ## START HERE AFTER A COMPACTION
>
> **This file is the active task.** *Set up on Opus 2026-09-05; the hunt itself had not started when the context was compacted.*
>
> 1. **Read [research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md) in full**, per [the reread rule](../.claude/rules/research-loop-reread.md). The loop sentinel is armed at `.claude/research-loop-active`.
> 2. **Read this whole file.** It is the position; the record below it is what the hunt starts from.
> 3. **Hunt for a proof of $J_5\ge0$**, or a refutation. Append every batch's outcome to the log at the foot.
>
> **THE MODEL SWITCH IS PENDING AND UNCONFIRMED.** The user proposed moving to Fable for this hunt and **had not yet said the switch happened**. *No tool reports the running model and the environment context goes stale, so this cannot be checked, ask the user and wait, and never record a model attribution as anything but a claim about what the user last said.*
>
> **Why this item and not the plan's top-graded one.** $J_5\ge0$ is the sole remaining grant of [I4](../plan.md), the only unfenced route to Problem P. The plan's own note records that its higher-graded neighbours (I22, I18, I5), could all close with the conjecture exactly as open.
>
> **What was agreed about method**: the four fences below close every rewrite through $W$'s spectral parts or through aggregated bracket data, so **a new idea has to leave $\mathrm{span}\{W_+,W_-\}$**. The equality locus is the most likely lever, the grant is sharp at every sphere product, at $\mathcal S^4(\alpha)$ and at $\mathbb{HP}^2$.

**Written on Opus 2026-09-05 as the position file for a Fable hunt.** *It states where the problem stands so the hunt starts from the record rather than from memory.* **Append derivations and outcomes below the line at the foot after every batch**, this file is the durable record of the hunt, and context is not.

## What is wanted, and why it is worth a strong model

**Prove $J_5\ge0$ at every critical point**, or refute it.

It is the sole remaining grant of **[I4](../plan.md)**, the lifted Jäger chain, [Conjecture L16](../findings/problem.md), which **settles Conjecture A outright for $n\ge12$**. Reading [INDEX-traps.md](../findings/INDEX-traps.md) by mechanism leaves exactly two unfenced routes to the target, and this chain is one of them. *So this is not a sub-step of a sub-step: it is the grant of the only live route to Problem P.*

## The object

$$J_5=\big\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}(\lvert W\rvert)\big\rangle,\qquad X_{\mathrm{inv}}=\lvert W\rvert^\#-P_+W^\#P_++P_-W^\#P_-,$$

with $P_\pm$ the spectral projections of $W$ and $\lvert W\rvert=W+2W_-$. **It replaced the refuted operator inequality $X_{\mathrm{inv}}\succeq0$ and is strictly weaker than it.**

Verified as an identity to $1.3\times10^{-14}$ at $12$ critical points across every named family, and **it holds at all of them, sharply**: equality at every sphere product, at $\mathcal S^4(\alpha)$ where $X_{\mathrm{inv}}=0$ identically, and at quaternionic-Kähler $\mathbb{HP}^2$; strictly positive at $SU(3)$, $J_5=2.73$.

### Three closed forms, each true, each fenced somewhere

Using the compressions $P_+W^\#P_-=P_0W^\#P_0=0$, verified to $10^{-15}$:

$$X_{\mathrm{inv}}=4\,W_+\#W_-\;-\;2\theta W_-\;-\;2W_-^2\qquad\text{at every critical point, [Theorem A](../ATTEMPTS.md); every cross block of }W^\#\text{ vanishes there, since }W^\#=\theta W-W^2\text{ commutes with }W.$$

**(1) The $\#$-calculus form**, at the native argument, where the $\langle X,W\rangle$ terms cancel identically by $W\#I=-W$ and $\mathrm{Alt}(W)=0$:

$$J_5=4\Big[\langle X_{\mathrm{inv}},W_-\rangle+\mathop{\mathrm{tr}}(X_{\mathrm{inv}}\#W_-)-3\langle X_{\mathrm{inv}},\mathrm{Alt}(W_-)\rangle\Big]=2\langle\mathrm{Ric}(X_{\mathrm{inv}}),g\rangle,$$

with $g=\mathrm{Ric}(W_-)=\mathrm{Ric}(W_+)\succeq0$ and $\mathrm{Ric}(\lvert W\rvert)=2g$.

**(2) The PSD-pairing form**, with no cross term and no $\#$-calculus:

$$J_5=4\langle C,H\rangle-2\langle\theta W_-+W_-^2,H\rangle,\qquad C=W_+\#W_-\succeq0,\quad H=\mathrm{Ric}^*(\mathrm{Ric}(\lvert W\rvert))\succeq0.$$

*Equivalently the grant is the frame-free $2\langle W_+\#W_-,H\rangle\ge\langle\theta W_-+W_-^2,H\rangle$ between pairings of PSD operators.* **Caution**: $\theta W_-+W_-^2\succeq0$ needs $\theta\ge-\lambda^+_{\min}(W_-)$, which is **not free**, [bounds-relaxations.md](../findings/bounds-relaxations.md) catalogues critical points with $\theta\le0$.

**(3) The bracket form, where the whole sign question sits.**

$$\mathop{\mathrm{tr}}(X_{\mathrm{inv}}\#W_-)=\tfrac12\sum_{i,j}x_i\mu_j\big\lVert[u_i,v_j]\big\rVert^2,$$

with $x_i$ the **signed** eigenvalues of $X_{\mathrm{inv}}$ and $u_i,v_j$ the respective eigenvectors. **The whole of the grant reduces to the sign of this one term**, so the object is $[\,\mathrm{ran}\,X_{\mathrm{inv}},\mathrm{ran}\,W_-]$.

## The four fences, and exactly what each one kills

**A fence post records that a *method* cannot work. None of them says $J_5\ge0$ is false**, the evidence is that it is true and sharp.

| post | kills |
| --- | --- |
| **[F54](../findings/second-order.md)** | Re-bounding $H$'s off-diagonal blocks by **trace data**. Any such bound is blind to $H$ scalar, where $H_{bc}=0$ and the cross term vanishes exactly, and carries an unavoidable $\sqrt{d_bd_c}=\Theta(n^2)$; closing the grant would need $d_bd_c\le1$, impossible at $n\ge4$. *Splitting the joint Cauchy–Schwarz is a strict loss, largest exactly in the favourable regime.* **And the condition number is not the missing factor**, $\kappa\ge K$ with $K_{\max}=n/4$, $\kappa=q/p$ at $S^p\times S^q$, and $\kappa=+\infty$ at Fox and at the plateau where the grant is sharp |
| **[F55](../findings/second-order.md)** | Two searches. **No $\Lambda^4$ cancellation exists to hunt**: $\#I$ acts by $c_4=2$ on $\Lambda^4$, so the third term cancels the counter-term exactly and the three-term form carries **zero** $\Lambda^4$ content. **And the $\#$-trace is inert against $W$ and $I$**, $\mathop{\mathrm{tr}}(X\#W)=-\langle X,W\rangle$ and $I\#I=(n-2)I$ collapse it against either Bianchi argument, leaving $W_-$ the sole argument outside the Bianchi subspace and the one place the calculus has no scalar to offer |
| **[F56](../findings/second-order.md)** | Signing $\mathop{\mathrm{tr}}(X_{\mathrm{inv}}\#W_-)$ by the polarised scalar-curvature identity, **and every variant at $\lvert W\rvert$, $W_+$, $W_-$ or any combination**. $\mathrm{Ric}$ restricted to $\mathrm{span}\{W_+,W_-\}$ has **rank one**, so for $B=\alpha W_++\beta W_-$ the identity returns $\tfrac{\alpha+\beta}4J_5$, a multiple of $J_5$ and nothing else. *The $\lvert W\rvert$ and $W_-$ readings are the same instance; $\alpha+\beta=0$ gives $W\#I=-W$* |
| **[F41](../findings/fence-posts.md)** | Stands over **any aggregate of bracket data**: the deficiency is invisible to the marginals of $\mathrm{ad}(v)$, and the maximal tori are where that bites |

### What the fences leave standing

- **The repair that survives F54** ([r410](REVIEW_r410.md)): shift by $\lambda_{\min}(H)$, free since $H-\lambda\mathrm{Id}\succeq0$ keeps the cross blocks, giving a bound that **vanishes with $H_{\mathrm{cross}}$** and the criterion $\kappa\le1+\mathop{\mathrm{tr}}X_{\mathrm{inv}}/(4D)$. *It scales as $\kappa-1=O(n^{-2})$, a sharpening of the commuting class rather than a route past it.*
- **Splitting $J_5$ into two nonnegative pieces is inert**, form (2) already does it, and an unsigned difference of two nonnegative numbers is strictly weaker than the signed block bound.
- Form (3) is **one of three unsigned terms, not the grant**. *An earlier reading that took it for the whole question was an overstatement and is withdrawn.*

## Where a new idea would have to come from

**Every fence closes a route that reads $J_5$ through $W$'s own spectral parts or through aggregated bracket data.** F56 is the sharpest statement of why: on $\mathrm{span}\{W_+,W_-\}$ the map $\mathrm{Ric}$ is rank one, so *nothing built inside that span is new information*. A successor therefore needs one of:

1. **An argument using $\mathrm{ran}\,X_{\mathrm{inv}}$ and $\mathrm{ran}\,W_-$ as subspaces**, not through any scalar aggregate of $\lVert[u_i,v_j]\rVert^2$, F41 covers the aggregates, and F56 covers the spectral rewrites.
2. **The equality case as the lever.** $J_5=0$ at every sphere product, at $\mathcal S^4(\alpha)$ and at $\mathbb{HP}^2$, and $>0$ at $SU(3)$. *A characterisation of the vanishing locus is a statement the record does not have, and it is the shape of an argument rather than a bound.*
3. **Criticality.** The grant is asserted **at critical points**; it is worth knowing whether it needs criticality at all, and if so which of relations (A), (B), (C) it consumes. *The audit found repeatedly that results filed as critical-point statements hold on all of $\mathcal W_n$.*

## Standing rules for this hunt

- **[analysis-only](../.claude/rules/analysis-only.md) is in force.** Computation needs the user's approval for the specific run, and approval does not carry to the next. **Permitted without asking**: screening a claim you are about to record, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. **Reserved**: searches, sweeps, optimisations, censuses, falsifier hunts.
- **The deliverable is an argument a human can read.** A certificate is not one.
- **Two reviewers on identical briefs** audit anything this hunt records, per [research-loop](../.claude/skills/research-loop/SKILL.md) step 2.
- **Append to this file after every batch.** Fable compacts near $160$k and context does not survive it; this file does.

---

## Hunt log

### Batch 1, the sign in this file's own definition, and what Gate 2 left of the rest

*Fable, 2026-09-05, on the user's statement that the switch happened. Gate 2: [r697](REVIEW_r697.md) and [r698](REVIEW_r698.md), identical briefs, agreeing on every claim. Recorded here in its reconciled form.*

**(1) THIS FILE'S DEFINITION OF $X_{\mathrm{inv}}$ CARRIED A WRONG SIGN, NOW CORRECTED IN PLACE, AND THE ERROR WAS WORSE THAN A SIGN.** The display above read $\lvert W\rvert^\#-P_+W^\#P_+-P_-W^\#P_-$; the record's primary statement ([ATTEMPTS.md](../ATTEMPTS.md), Result 3) reads $\lvert W\rvert^\#-P_+W^\#P_++P_-W^\#P_-$, **the negative block entering with the sign of $W$ on it because $\lvert W\rvert=-W$ there.** [r697](REVIEW_r697.md) proves by hand that at $S^p\times S^q$ the record's operator vanishes identically, $\mathrm{Ric}(W)=0$ gives $a(p-1)+b(q-1)=-cn$, criticality gives $\theta=\lvert c\rvert(n-1)$, and $4(W_+\#W_-)$ on the cross block equals $2c^2n$, cancelling $2\theta\lvert c\rvert+2c^2$ exactly, **while the variant this file carried equals $4W_+\#W_-$, which is PSD.** *A hunt started from the uncorrected file would therefore have "proved" the grant in one line, for the wrong operator.* Screened first at $S^2\times S^4$, $S^3\times S^3$, $S^3\times S^5$: the variant has $\lVert X\rVert=1.60$ and $J_5=+12.1$ at $S^3\times S^3$ where the record's closed form gives $0$ to $10^{-16}$.

**(2) $H=\mathrm{Ric}^*(h)$ IS DIAGONAL IN THE EIGENFRAME OF $h=\mathrm{Ric}(\lvert W\rvert)$, WITH EIGENVALUES $\eta_i+\eta_j$.** For $\{e_i\}$ diagonalising $h$ with eigenvalues $\eta_i$, the Kulkarni–Nomizu expansion $\langle(h\owedge\mathrm{id})(e_i\wedge e_j),e_k\wedge e_l\rangle=\eta_i\delta_{ik}\delta_{jl}-\eta_i\delta_{il}\delta_{jk}-\eta_j\delta_{jk}\delta_{il}+\eta_j\delta_{jl}\delta_{ik}$ collapses to $(\eta_i+\eta_j)\delta_{ik}\delta_{jl}$ for $i<j$, $k<l$; robust to degenerate and mixed-sign $\eta$. *The factor $2$ this batch first wrote double-counted the two live $\wedge$ conventions ([r697](REVIEW_r697.md), [r698](REVIEW_r698.md)); the true adjoint of $\mathrm{Ric}$, built numerically, is diagonal in the $h$-frame to $5\times10^{-15}$ with entries $\eta_i+\eta_j$.* **What it buys, and the record keeps it**: when $h=\lambda\,\mathrm{id}$, $H=2\lambda\,\mathrm{Id}$ and $J_5=\lambda\mathop{\mathrm{scal}}(X_{\mathrm{inv}})\ge0$ by Result 5(a), the grant is **proven on exactly the locus [post F54](../findings/second-order.md) names as the blind spot of every trace bound.** *What it does not buy: the frame-free reading. $H_{\mathrm{cross}}=0$ in the $P_\pm/P_0$ split holds iff $[H,W]=0$, which is Theorem B's frame-free condition rather than an artefact of the split, and "$J_5$ sees no off-diagonal information in any frame" is false as stated.*

**(3) THE VALIDATION DEBT ON THE LADDER REFUTATION IS DISCHARGED.** $A\succeq0\Rightarrow\mathrm{Ric}(A)\succeq0$ via $\langle\mathrm{Ric}(A)x,x\rangle=\sum_j\langle A(x\wedge e_j),x\wedge e_j\rangle$, and the chain $X_{\mathrm{inv}}\succeq0\Rightarrow\mathrm{Ric}(X_{\mathrm{inv}})\succeq0\Rightarrow J_5\ge0$, are the record's own ([ATTEMPTS.md](../ATTEMPTS.md), the $n=5$ refutation), and the $H\succeq0$ route offered here is Result 5(b)'s proof transposed. **What is new is the reproduction**: the record's refutation of $\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$ was a single unreviewed run; an implementation sharing no code with it, the sharp square by structure constants, validated on $W\#I=-W$ and against the library's bracket form to $4\times10^{-16}$, reads the same witness ([j5cross_n5_newcrit_th0.882.npy](../agent_logs/j5cross_n5_newcrit_th0.882.npy)) and returns $\lambda_{\min}(\mathrm{Ric}(X_{\mathrm{inv}}))=-0.0273$, criticality residual $1.6\times10^{-8}$, next eigenvalue $+0.0543$. *The sign survives the residual by six orders. The ladder is closed as the record says.*

**(4) THE REDUCED FORM'S REMAINDER IS ZERO AT EVERY CRITICAL POINT, AND THE SEARCH THIS BATCH RESERVED WAS FOR A POINT THAT CANNOT EXIST.** For every symmetric $W$ and every scalar $\theta$, $X_{\mathrm{inv}}=4W_+\#W_--2\theta W_--2W_-^2+\big(Q(W)-\theta W\big)$, purely from $\lvert W\rvert^\#=W^\#+4W_+\#W_-$, $W\lvert W\rvert=W_+^2-W_-^2$ and $W^2=W_+^2+W_-^2$ (screened at random symmetric $W$, $n=5,6,7$, residual $\le3\times10^{-15}$). **But $Q$ preserves $\mathcal W_n$**, [BW08 eq. 6](../references/boehm-wilking-2008-space-forms/notes.md) gives $\mathrm{Ric}(R^2+R^\#)_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$, zero on Weyl tensors, **and a critical point is $Q(W)=\theta W$ as an operator** ([conventions.md](../findings/conventions.md)), so the remainder vanishes and the identity is [Theorem A](../ATTEMPTS.md) at every critical point. *The approved run, made before the reviewers landed, confirmed what the definitions already said: $\mathrm{Ric}(Q(W))=0$ to $10^{-15}$ at the $n=5$ critical point and at five non-critical Weyl tensors; [post F55](../findings/second-order.md)'s boxed form is complete.* **Two corrections to this file follow.** The display above once carried a remainder $P_\pm W^\#P_0+P_0W^\#P_\pm$: at a critical point $W^\#=\theta W-W^2$ commutes with $W$, so every cross block of $W^\#$ is zero and that term with it, which also strikes the second of the four routes this file proposed for a new idea, and gives the free repair $X_{\mathrm{cross}}=4(W_+\#W_-)_{\mathrm{cross}}$ exactly.

**Deliverable: one refutation, this file's own definition, upgraded by Gate 2 from a sign to a wrong-operator error; one validation debt discharged; one proposed route struck. The $h$-scalar case of the grant is recorded at [post F54](../findings/second-order.md).**

### Batch 2, the equality locus: $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0$ forces $X_{\mathrm{inv}}=0$, and at scalar $h$ that is the grant's equality

*Fable, 2026-09-05. Gate 2: [r699](REVIEW_r699.md) and [r700](REVIEW_r700.md), identical briefs, both CONFIRMED with the same corrections, applied here. Recorded as [Lemma L154](../findings/bounds.md).*

**The lemma as it stands after review.** Let $W\ne0$ be a critical point. **(i)** $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0$ iff $X_{\mathrm{inv}}=0$. **(ii)** If $h=\mathrm{Ric}(\lvert W\rvert)=\lambda\,\mathrm{id}$, as it is whenever $W$'s isotropy acts irreducibly on $\mathbb R^n$ over $\mathbb R$, $h$ being symmetric and equivariant so that an eigenspace is an invariant subspace, then $\lambda=2\mathop{\mathrm{tr}}\lvert W\rvert/n>0$, $H=2\lambda\,\mathrm{Id}$, $J_5=\lambda\mathop{\mathrm{scal}}(X_{\mathrm{inv}})\ge0$, and $J_5=0$ iff $X_{\mathrm{inv}}=0$. *Corrections taken: the constant (the batch wrote $\lambda\mathop{\mathrm{tr}}$ for $2\lambda\mathop{\mathrm{tr}}$), $W\ne0$, "over $\mathbb R$" with the symmetric-eigenspace argument in place of bare Schur, and, [r699](REVIEW_r699.md)'s substantive one, the row argument never reads $h$, so (i) holds at every critical point and scalar $h$ serves only to identify $J_5$ with the trace.*

**Proof of (i).** $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=\sum_b\mathop{\mathrm{tr}}(P_bX_{\mathrm{inv}}P_b)$ with $P_+X_{\mathrm{inv}}P_+=4P_+CP_+$, $P_-X_{\mathrm{inv}}P_-=2P_-(W_+^\#+W_-^\#)P_-$, $P_0X_{\mathrm{inv}}P_0=P_0\lvert W\rvert^\#P_0$ ([Result 5(a)](../ATTEMPTS.md)), each PSD. Trace zero makes each block zero; a PSD operator with a zero diagonal block vanishes on that block's row, so $P_+C=0$ and $P_0\lvert W\rvert^\#=0$, whence $P_0C=0$ from $4C=\lvert W\rvert^\#-W^\#$ and $P_0W^\#=0$ ($W^\#=\theta W-W^2$ kills $\ker W$). So $C=P_-CP_-$, and [Theorem A](../ATTEMPTS.md)'s $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2$ is supported in the $--$ block, which is zero. $\square$

**What is new and what is not.** $\mathop{\mathrm{scal}}(X_{\mathrm{inv}})\ge0$ is Result 5(a) and [Lemma L7](../findings/bounds.md), $\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}$ is L7's slack ([r699](REVIEW_r699.md)); $J_5\ge0$ at scalar $h$ is batch 1 (2). **New is the step from trace zero to operator zero**, which upgrades L7's equality class from a trace statement to $X_{\mathrm{inv}}=0$. *Screened with the record's constructors: $\mathbb{HP}^2$ has $h$ scalar, $J_5=0$ and $X_{\mathrm{inv}}=0$ to $1.4\times10^{-15}$; $SU(3)$ has $h$ scalar, $J_5=2.73$ as recorded, $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=1.14$. Both numerical; the sphere products are proven by [r697](REVIEW_r697.md)/[r698](REVIEW_r698.md), covering the unbalanced ones where $h$ is not scalar.*

### Batch 3, the equality locus in closed form: $X_{\mathrm{inv}}=0$ iff $\mathop{\mathrm{ran}}W$ is a graded subalgebra

*Fable, 2026-09-05; reached independently by [r699](REVIEW_r699.md). Gate 2 on Opus: [r701](REVIEW_r701.md) and [r702](REVIEW_r702.md), identical briefs, both CONFIRMED. **Recorded as [Lemma L155](../findings/bounds.md)**, in the stronger form the reviewers established.*

**What the batch claimed, and what it turned out to be.** The batch stated the equivalence *at a critical point*, routed through [L154](../findings/bounds.md)(i). **[r701](REVIEW_r701.md) found criticality is never used**: under the three inclusions $W_\pm^\#$ live on $\mathfrak p$ and $C$ on $\mathfrak m$, so $X_{\mathrm{inv}}$ collapses by expansion, and the block formulas it inverts are hypothesis-free algebra. So the statement holds **at every symmetric $W\ne0$**, and L154(i) inherits a shorter proof. *[r702](REVIEW_r702.md) proved the critical-point case by a second route, through $P_0(W_+^\#+W_-^\#)P_0=2P_0CP_0$; the two verdicts differ in reach rather than in content, and the wider one is recorded.* **Reproduced independently before recording** ([run_j5_grading_screen.py](../scripts/runs/run_j5_grading_screen.py), objects built in the script): graded but non-critical $W$ gives $X_{\mathrm{inv}}=0$ to machine zero at four configurations with criticality residuals $3.0$ to $76.1$.

**Three corrections carried into the record.** Antisymmetry makes $[\mathfrak p,\mathfrak m]\perp\mathfrak p$ and $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ one condition, so the class is cut out by two ([r702](REVIEW_r702.md)). [Lemma L7](../findings/bounds.md)'s hedge *"conditions modulo $\ker W$"* is retired, the $00$ block supplies closure, which is the batch's genuinely new content against [ATTEMPTS.md](../ATTEMPTS.md)'s trace-level $S=T_1+2T_2+T_3$. And L7's caveat that $W_{\mathbb{CP}^2}$ at $n=4$ has *"no $\mathbb Z_2$-grading at all"* is overstated: $\mathop{\mathrm{ran}}W=\Lambda^2_+\cong\mathfrak{so}(3)$ is graded as $(\mathfrak{so}(3),\mathfrak{so}(2))$, and what is true is that $\mathop{\mathrm{ran}}W_+$ alone is the even part of none.

**The batch's screen sentence about padded $\mathbb{CP}^2$ at $n=6$ is WITHDRAWN.** It named no definite object: zero-padding preserves the grading, $X_{\mathrm{inv}}(W\oplus0)=X_{\mathrm{inv}}(W)\oplus0$, so $W_{\mathbb{CP}^2}\oplus0$ is graded at every $n$ and cannot be the failing point ([r701](REVIEW_r701.md), [r702](REVIEW_r702.md)). *The object the batch measured was the $n=6$ Weyl projection of the zero-padded tensor, which is a different tensor; nothing rests on it, and the named points $W_{\mathbb{CP}^2}$ at $n=4$ and $SU(3)$ are settled by hand in [L155](../findings/bounds.md).*

**What it does to the hunt.** Routes (1) and (2) above merge: the equality locus of $X_{\mathrm{inv}}$ is a Lie-theoretic condition on $\mathop{\mathrm{ran}}W$ and nothing spectral, and it needs no criticality. *The open question is now posed sharply: **is $J_5=0$ only at graded critical points?** A counterexample needs non-scalar $h$, [L154](../findings/bounds.md)(ii) closes the scalar case, with a diagonal of $X_{\mathrm{inv}}$ in $h$'s frame whose entries cancel against the weights $\eta_i+\eta_j$.*

**Deliverable: one derivation, Gate 2 passed, recorded as [Lemma L155](../findings/bounds.md).**

### Batch 4, the sweep's dropped term, and what survived Gate 2 of the split that found it

*Derived on Fable, reviewed on Opus, both per the user's statement. Gate 2: [r703](REVIEW_r703.md) and [r704](REVIEW_r704.md), identical briefs, agreeing. **Most of what the batch claimed as new was already on the record; what follows is the reconciled remainder.***

**(1) REFUTATION, and it reaches further than the batch saw: the record's transcription of [BW08 eq. (6)](../references/boehm-wilking-2008-space-forms/notes.md) is sign-wrong.** [The 2026-09-03b sweep](2026-09-03b-LIT-step8-sweep.md) dropped a route on the ground that $\sum_a\lambda_a\mathop{\mathrm{tr}}((\omega_ag)^2)$ is *"indefinite for every $a$"*, and [plan.md](../plan.md)'s I4(a) repeats it as *"F56-class, dropped"*. **The quantity is signed**: $\mathop{\mathrm{tr}}(\omega g\omega^{\mathsf T}g)=\lVert g^{1/2}\omega g^{1/2}\rVert_F^2\ge0$ for $g\succeq0$, so $\mathop{\mathrm{tr}}((\omega g)^2)$ is $\le0$; the sweep's own $g=E_{11}$ check exhibits degeneracy rather than a sign change. **The origin, found independently by both reviewers**: the sweep reads eq. (6) with index pattern $R_{kijk}$, and $\sum_kR_{kijk}=-\mathrm{Ric}_{ij}$, so the transcription is the negative of the record's own $\mathring{\ }$. *Verified by the anchor $R=\mathrm{Id}$, where the left side is $(n-1)^2\mathrm{id}$ and the transcribed right side is $-(n-1)^2\mathrm{id}$, a two-line check needing no computation.* **The notes carry BW's convention verbatim with no warning, so the defect is in [references/](../references/boehm-wilking-2008-space-forms/notes.md) and the sweep inherited it.**

**What this does NOT establish.** *"The route is open" is withdrawn.* The sweep closed it on two grounds and only one is wrong; **[post F56](../findings/second-order.md) is untouched**, and a successor through the $D(R)$ identity owes the argument that it escapes F56 rather than assuming the sign correction supplies one.

**(2) THE SPLIT IS THE RECORD'S OWN, RECORDED AS CORROBORATION.** The four-term identity the batch derived is [ATTEMPTS.md](../ATTEMPTS.md)'s **Result 1** of the Jäger-lift section, term for term ([r704](REVIEW_r704.md), which proved both identifications: $J_4=6\langle\mathcal A,h\rangle$, and the leading term equals $\sqrt2\,r^2\sqrt{1-\mathop{\mathrm{tr}}S^4}\sqrt{1-e^2}$ via $\lVert S\owedge S\rVert^2=2(1-\mathop{\mathrm{tr}}S^4)$, where its nonnegativity is already a product of two square roots). *The supporting identity $4\,\mathrm{Ric}(C)=\mathring{\lvert W\rvert}(h)+6\mathcal A$ is **Result 2**, not Result 4 as the batch and its brief both cited; it is CONFIRMED by both reviewers, proved twice by hand, criticality-free, with the $6$ forced rather than fitted.* **A second route reaching a recorded identity is corroboration, and is recorded as that.**

**(3) WHAT IS NEW: the sectional reading, and it is convention-free.** In the eigenframe of $h$, with $\mathbf w_{ab}=\langle\lvert W\rvert(e_a\wedge e_b),e_a\wedge e_b\rangle\ge0$ the sectional matrix of $\lvert W\rvert$ and $\eta$ the eigenvalues of $h$,

$$\eta=\mathbf w\mathbf 1\quad(\text{frame-free}),\qquad \text{leading term}=\sum_{a\ne b}\eta_a\eta_b\,\mathbf w_{ab}=\mathbf 1^{\mathsf T}\mathbf w^3\mathbf 1,\qquad \lVert h\rVert^2=\mathbf 1^{\mathsf T}\mathbf w^2\mathbf 1 .$$

**Stated this way it needs no $\mathring{\ }$ convention and its nonnegativity is manifest**, both factors being nonnegative. *A trap the batch fell into and both reviewers caught: the batch's $\mathring R(s)_{ik}=\sum_{jl}R_{ijkl}s_{jl}$ is the **negative** of [conventions.md](../findings/conventions.md)'s declared $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$, internally consistent, sign-flipped on import. Screened: the two orders give $+8.3656$ and $-8.3656$ at $S^2\times S^4$.* **The claim that the grant is "a statement about one nonnegative matrix and $\theta$" is withdrawn**: $2\langle\mathrm{Ric}(W_-^2),h\rangle$ needs $W_-$'s off-diagonal entries, outside $\mathbf w$.

**(4) THE REDUCED CONDITION, now proved rather than screened.** Dropping $6\langle\mathcal A,h\rangle$ and using $\lVert W_-\xi\rVert^2\le\lambda_{\max}(W_-)\langle W_-\xi,\xi\rangle$ gives the sufficient condition

$$\eta^{\mathsf T}\mathbf w\eta\;\ge\;\big(\theta+\lambda_{\max}(W_-)\big)\lVert\eta\rVert^2 ,$$

**sufficient at every critical point**, the $\mathcal A=0$ qualifier the batch attached is unnecessary ([r704](REVIEW_r704.md)), and an **exact equality at every sphere product**, proved by hand by both reviewers from [r697](REVIEW_r697.md)'s closed forms and no longer resting on a screen. *[r704](REVIEW_r704.md) adds the structural reason: $\mathbf w\eta=n\eta$ there, so $\eta$ is $\mathbf w$'s Perron vector at eigenvalue exactly $\theta+\lambda_{\max}(W_-)$, which yields a free necessary screen, $\lambda_{\mathrm{Perron}}(\mathbf w)\ge\theta+\lambda_{\max}(W_-)$.*

**(5) THE FENCE, restricted to what it holds.** *What the batch claimed (that any proof of $J_5\ge0$ must use $\mathrm{Alt}(W_-)$ quantitatively), is **REFUTED at the point offered as forcing it**: $\mathbb{HP}^2$ has scalar $h$, so [L154](../findings/bounds.md)(ii) already proves the grant there with no $\mathrm{Alt}$ anywhere, as at $SU(3)$ and the balanced sphere products ([r703](REVIEW_r703.md)). And its sharpness there is a tautology, $X_{\mathrm{inv}}=0$ at $\mathbb{HP}^2$ forces $J_5^{\mathrm{sec}}=-6\langle\mathcal A,h\rangle$ identically, so the $10^{-15}$ screen re-measured a definition.* **What holds: no bound that discards $6\langle\mathcal A,h\rangle$ from this decomposition closes the grant.** Its live witness is the recorded $n=5$ critical point, where $h$ is **not** scalar, eigenvalues $0.8045$ to $1.2156$, so L154(ii) does not reach it, and the reduced condition fails by $-0.72$ against $6\langle\mathcal A,h\rangle=+0.75$. *That witness is numerical and has no closed form ([r704](REVIEW_r704.md)); it is a recorded object rather than a new search, and the fence is labelled by it rather than proved from it.*

**(6) A THIRD EQUALITY FAMILY THE BATCH DROPPED.** $\mathcal S^4(\alpha)$ has $X_{\mathrm{inv}}=0$ **with nonzero defect**, and is the one sharp family that is not coordinate-diagonalisable ([r704](REVIEW_r704.md)). *Any proof shape aiming at this decomposition has three equality families to be exact on (the sphere products, $\mathbb{HP}^2$, and $\mathcal S^4(\alpha)$), not two.*

**Deliverable: one refutation, reaching a defect in [references/](../references/boehm-wilking-2008-space-forms/notes.md); one corroboration of Result 1; one derivation kept (the sectional reading and the reduced condition's proved exactness); one fence, restricted.**
