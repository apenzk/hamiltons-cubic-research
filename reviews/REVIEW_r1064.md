# REVIEW_r1064: the I110 fold, the typed exclusion, post F73's sweep, and the two sign corrections

Reviewer `r1064`. A comparison round against fixed text: everything below is already written down, and the question is where the writing departs from what it cites. Analysis only, with one screen of the record's own arithmetic at the corner already in radicals.

Log: [agent_logs/r1064-fold-and-sweep.log](../agent_logs/r1064-fold-and-sweep.log)

## Verdict table

| item | claim | verdict |
| --- | --- | --- |
| A | the fold's nine numbers reproduce what [r1062](REVIEW_r1062.md) and [r1063](REVIEW_r1063.md) recorded | **CONFIRMED**, all nine to the digits printed |
| A-route | "step 8's second link gives up $0.2505$ at $x_i<0$ against a deficit of $0.0148$" | **REFUTED**, twice over: the figure is a bare shape factor compared against a quantity carrying $u\lVert r\rVert^2$, and it belongs to a shape the corner does not take |
| A-scope | the fold's account of what holds off the corner | PLAUSIBLE, with one framing widened and one reason repeating a gloss both reviewers corrected |
| B | [patternG](../lean/HamiltonsCubic/Results/I110Deficit.lean), the two apply lemmas, and [forced_shape_of_top](../lean/HamiltonsCubic/Results/I110Deficit.lean) against the prose | **CONFIRMED**, `A - B < B - A` is the exact reading of "the equality case is the TOP eigenvector" |
| B-reach | the section docstring's "which is the whole of the exclusion" | **REFUTED**, the sign step is typed and the flip in $F$ is not |
| C1 | Lasserre's local content is [L24](../findings/second-order.md) exactly | **CONFIRMED**, constants and the sign flip both check |
| C2 | Theorem 3.3 supports what [post F73](../findings/fence-posts.md) draws from it | **REFUTED**, F73 rests on the definition of a spurious extremum plus the record's own Morse-Bott table, and Corollary 3.1(i) can reach no cubic at all |
| C3 | padded $W_{\mathbb{CP}^2}$ is a second-order point with excess $0$ | **CONFIRMED**, with the fourth-order inequality an EQUALITY there rather than vacuous |
| C-reach | the class of theorem F73 closes | **REFUTED as worded**, read literally it closes [I104](../plan.md), [I110](../plan.md) and [I111](../plan.md) along with the literature |
| D1 | the $\lvert c\rvert$ rewrite | PLAUSIBLE, correct where applied and left unapplied in the two sentences that state the successor criterion |
| D2 | the $\pm(1,1,1)$ rewrite | **REFUTED**, the inserted correction contradicts the two bolded conclusions of its own paragraph, which still stand |
| E | index rows, ids, plan sections, the trap number, anchors | **CONFIRMED**, with one stale Lean line anchor and one register never written |

## A, the fold's arithmetic is exact, and its route sentence is not

**Every number in the fold reproduces, from $\theta=\sqrt{3/2}$ and $s_*=\tfrac{\sqrt6+\sqrt{10}}{12}$ alone.** Screened in seconds on the corner the file already carries in radicals.

| the fold's figure | recomputed | source |
| --- | --- | --- |
| $F(u_{\mathrm{lo}})=-0.0148730$ | $-0.014873034$ | [r1062](REVIEW_r1062.md) |
| $F+\sqrt3u^3=+0.1297823$ | $+0.129782260$ | [r1062](REVIEW_r1062.md) |
| $\sqrt3u^3=0.1446553$ | $0.144655294$ | the difference of the two |
| pinning $0.08278634$ | $0.082786343$ | [r1062](REVIEW_r1062.md) |
| cross $0.05519090$ | $0.055190895$ | [r1062](REVIEW_r1062.md) |
| Rayleigh $1.1014$ against $0.2524$ | $1.1014346$ against $0.2523659$ | [r1062](REVIEW_r1062.md) gives the cap as the value $0.0385747$, and $0.2524=u_{\mathrm{lo}}/\sqrt3$ is the same cap as a quotient |
| factor $4.4$ | $4.364$ | consistent with both |
| $P(D)$ required $+0.172853$ | $\theta(t-\tfrac N2)+3\tau=+0.172850$ | [r1063](REVIEW_r1063.md) |
| $P(D)$ forced $-0.130190$ | $-0.9\sqrt3u_{\mathrm{lo}}^3=-0.130190$ | [r1063](REVIEW_r1063.md) |
| gap $0.303$, twenty times | $0.303040$, $20.4$ times | arithmetic on the two |
| $\lVert\tfrac35\sum q_a\rVert^2=\tfrac95u^2$ | $\tfrac9{25}\cdot5u^2$ | [r1063](REVIEW_r1063.md) step 3 |

**The $G$ computation the fold performs for itself is right, including the order of entries.** With $C=B$, $G(0,1,-1)=(0,B-A,A-B)$ and $G(2,-1,-1)=(-2(B-A),B-A,B-A)$, so the two eigenvalues on $\mathbf1^\perp$ are $\pm(B-A)$ and the equality case is the top one exactly when $B>A$.

### Finding A1, the $0.2505$ is a shape factor and the deficit is not, so "seventeen times" is a comparison of two different quantities

**[r1059](REVIEW_r1059.md) prices the $x_i>0$ side with the conversion and the $x_i<0$ side without it.** Its own formula is $(\tfrac1{\sqrt3}-\max)\,u\,(t-u^2)$, and it applies it in one paragraph, $0.001771\times0.437539\times0.154560=0.00012$, then in the next paragraph reports $0.2505$ as what the link "gives up". The factor $u(t-u^2)=0.0668$ is dropped between the two sentences.

**Converted, the figure is $0.0167$ to $0.0169$, which is $1.13$ times the deficit rather than seventeen.** At the corner's own numbers, $0.2505\times0.4371105\times0.1528525=0.016737$, and at [r1059](REVIEW_r1059.md)'s $t=0.346$, $u=0.437539$ it is $0.016940$.

**The same slip is what makes the record's other second-link numbers look like deficits.** $0.0105$ at $(3,-1,-2)$, $0.0148$ at $(1,-0.3,-0.7)$ and $0.0774$ at $(1,-1,0)$ are all $\tfrac1{\sqrt3}-\max(x,y,z)$ at the unit shape, reproduced here to six places. *The coincidence [r1059](REVIEW_r1059.md) confirmed on the commit clock is therefore a coincidence between a dimensionless shape gap and a value in $F$'s units, which is a second reason it was never a target.*

### Finding A2, the $0.2505$ belongs to a shape the corner does not take, and the corner's own number is larger

**[r1059](REVIEW_r1059.md)'s configuration is $(-0.5756,0.3269,0.2487)$**, which has $y\ne z$. **[I110](../plan.md) forces $y=z$**, so the corner's unit shape is $(-2,1,1)/(2\sqrt3)=(-0.57735,0.288675,0.288675)$ and its gap is $\tfrac1{\sqrt3}-\tfrac1{2\sqrt3}=0.288675$, not $0.2505$.

**In $F$'s units the corner's gain is $0.0192874$ against a deficit of $0.0148730$, a margin of $30\%$.** That number is already on the record as [r1062](REVIEW_r1062.md)'s halved cap, $\tfrac{u}{2\sqrt3}\lVert r\rVert^2=0.0192874$ against $\tfrac{u}{\sqrt3}\lVert r\rVert^2=0.0385747$, offered there as reinforcement for the exclusion and never connected to the route. **So the two readers each hold half of the correct figure and neither states it**, and the fold quotes the third number, which is neither.

**What this does to [I111](../plan.md).** The route survives in kind, because $0.0193>0.0149$, and its margin is $30\%$ at one point rather than seventeen-fold across a regime. *The item's own gap then bites harder than its text suggests: [r1059](REVIEW_r1059.md) records that at the other surviving configuration the forcing gives only $x/u\ge0.3976$, so the second link's slack there lies anywhere in $[0,0.1797]$ and is free, while [deficit_strictMonoOn](../lean/HamiltonsCubic/Results/I110Deficit.lean) makes the deficit smaller at every $s<s_*$.* **Off the corner a shrinking deficit races a gain that may reach zero, and the race is what I111 owes.** The correction recommended is to replace the sentence with the corner's own pair, $0.0193$ against $0.0148730$, and to state the comparison as a margin to be defended over the region.

### Finding A3, two places where the fold states a little more than its sources

**Condition 2's stated reason is the gloss both reviewers corrected.** The fold writes "the product bound is saturated, since the two sides of the block equation have equal norm". The two sides of an equation have equal norm unconditionally, and saturation follows only with $\tau$ at G6's bound, which is part of the corner's definition. [r1062](REVIEW_r1062.md)'s Finding 3 and [r1063](REVIEW_r1063.md)'s D5 section both say this in terms, and the fold's "since" clause restores the reading they removed. *The conclusion is untouched, and the reason should read "since the corner puts $\tau$ at G6's bound".*

**"The true worst case moves to a less-pinned configuration where the Gram bound is slack" is a prediction printed under "WHAT THIS DECIDES".** It is verbatim from [I110](../plan.md)'s pre-settlement outcome clause, so the attribution is honest, and neither reviewer establishes anything about where the worst case moves. *It also points away from [I111](../plan.md), which is opened in the same commit and works the corner's own regime, so the fold decides one thing and the plan pursues another.*

**One factor of two in the prose.** "$q_i$'s $\mathbf1^\perp$-component is $\tfrac{B-A}3(-2,1,1)$" is the $\mathbf1^\perp$-component of $(A,B,C)$, which is $2q_i$ under Bianchi, $q_i$ itself being $\tfrac{B-A}6(-2,1,1)$. The conclusion drawn from it, a positive multiple of $(-2,1,1)$, is unaffected.

## B, the typed exclusion states what it should, and its docstring states more

**[patternG](../lean/HamiltonsCubic/Results/I110Deficit.lean) is [L121](../findings/second-order.md)'s $G$ entry for entry**, `!![A, C, B; C, B, A; B, A, C]` against $\begin{pmatrix}A&C&B\\C&B&A\\B&A&C\end{pmatrix}$, and the docstring's $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$ and the factor $\tfrac12$ are L121's own.

**[patternG_apply_equalityCase](../lean/HamiltonsCubic/Results/I110Deficit.lean) and [patternG_apply_shape](../lean/HamiltonsCubic/Results/I110Deficit.lean) are the two eigenvector facts and neither is vacuous.** Both are specialised to $C=B$, which is what the product bound's equality case forces, and both reproduce by hand.

**`A - B < B - A` is the exact reading of "the equality case is the TOP eigenvector", neither weaker nor stronger.** The two eigenvalues are $B-A$ on $(0,1,-1)$ and $A-B$ on $(2,-1,-1)$, so "top" is $B-A>A-B$, which is the hypothesis verbatim. *The strictness excludes only $A=B$, where $G$ vanishes on $\mathbf1^\perp$ and $q$ is zero in the plane, which $u_{\mathrm{lo}}>0$ already excludes at the corner.* **So the hypothesis is satisfiable and the theorem is not vacuous.**

**The conclusion's second half is an identity that holds without the hypothesis.** $![A,B,B]-\tfrac{A+2B}3$ equals $\tfrac{B-A}3\cdot![-2,1,1]$ for all $A$ and $B$, and only $0<\tfrac{B-A}3$ consumes `htop`. *That is the honest shape for the step, a decomposition plus a sign, and it is worth saying in the docstring so a reader does not look for eigenvector content in the second conjunct.* In the intended application $A+B+C=0$, so the mean subtracted is zero and the vector typed is $2q$.

**The over-claim is one sentence.** The section docstring reads "This section types that step, which is the whole of the exclusion". The sign step is one of three: the shape forcing, the value $P(q)=-\tfrac{\sqrt3}2u^3$ at that shape, and the flip of $F$ to $+0.1298$. **Only the first is typed**, and [r1062](REVIEW_r1062.md) already noted the third is one polynomial inequality away from [deficit_at_sStar](../lean/HamiltonsCubic/Results/I110Deficit.lean). *The docstring should say that it types the sign step, which is the step the exclusion turns on.*

**The file elaborates**, exit $0$, no `sorry` and no `native_decide`, with three `unusedSimpArgs` warnings on `Matrix.head_cons` at lines 308, 316 and 330.

## C, post F73 reaches its conclusion by a different road than the one it names

### C1, the local content really is L24, constants and sign

**Derived from [Corollary 2.2](../references/lasserre-2021-spurious-local-minima-sphere/notes.md) as stored.** At a local minimiser of a degree-$d$ form, SONC reads $u^{\mathsf T}\nabla^2f(x^*)u\ge d\,f(x^*)$ on $(x^*)^\perp$. For maximising $P$, put $f=-P$, so $f(W)=-\theta$ and $\nabla^2f=-6L_W$, and the inequality becomes $6\,u^{\mathsf T}L_Wu\le3\theta$, that is $\lambda_{\max}(L_W\vert_{W^\perp})\le\tfrac\theta2$. **With $L_e=L_W/\theta$ that is $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$, which is [L24](../findings/second-order.md).** The $W$-eigenvalue $d(d-1)\theta=6\theta$ quoted in the notes is the same normalisation read at $u=W$. *The sign flip is handled correctly in both the notes and the post, and $d=3$ with $\nabla^2P=6L_W$ is what makes the two constants cancel to $\tfrac12$.*

### C2, Theorem 3.3 is not what carries the post, and the post's conclusion is still true

**What Theorem 3.3 says, as stored.** A sufficient condition, that $f$ has no spurious local minima if exactly one component $\tilde W_{j^*}$ of the gradient variety of $g=f-\tfrac d{d+2}\lVert x\rVert^2f$ meets $\Omega$, plus a partial converse, that no spurious local minima implies the SONC points of value $f^*$ lie in a unique $\tilde W_{j^*}\cap\Omega$.

**What [F73](../findings/fence-posts.md) and the [sweep note](2026-09-22-LIT-step8-sweep.md) say it says.** "A form has no spurious local extrema iff its SONC points all share one value." **That is a third statement.** The constancy form is [Corollary 3.1](../references/lasserre-2021-spurious-local-minima-sphere/notes.md)(i), it is sufficient only, and it carries a nonnegativity hypothesis. *The same sentence appears a third time in [INDEX-traps.md](../findings/INDEX-traps.md)'s row 73.*

**Corollary 3.1(i) can apply to no cubic whatever.** A nonzero form of odd degree satisfies $f(-x)=-f(x)$, so it is never nonnegative. **So the corollary is vacuous at $d=3$ and cannot be the source either.**

**Using the theorem's contrapositive would need the gradient variety's components**, which is exactly the census the sweep grades analytic $0$ and files as [R12](../routes.md). *So the post cannot both retire the census and draw on a theorem stated through it.*

**And "$P$ provably HAS spurious local maxima" does not follow from a SONC point below the sphere product's value, because SONC is necessary and not sufficient.** A SONC point can be a saddle. **The record supplies what is actually needed, one table away**: padded $W_{\mathbb{CP}^2}$ has $B\vert_{W^\perp}\succeq0$ and excess $0$ in [second-order.md](../findings/second-order.md)'s R8 table, which is Morse-Bott nondegeneracy with kernel exactly the orbit tangent, hence a genuine local maximum modulo the group. **With $\sqrt{3/2}=0.9909\,\theta_0(12)$ it is below the balanced product, so it is spurious.**

**So F73's conclusion stands and its citation does not.** What it rests on is the definition of a spurious local maximum, the record's own Morse-Bott data, and the value comparison. *Lasserre supplies the vocabulary and the confirmation that the literature's local content is already L24, which is worth recording, and supplies no theorem that P fails.*

### C3, excess $0$ is right, and the fourth-order condition is an equality rather than a vacuity

**Both second-order facts check against the record.** $\lambda_{\max}(L_W\vert_{W^\perp})/\theta=\tfrac12$ exactly at every padding of $W_{\mathbb{CP}^2}$, padding-invariant because $\mathfrak{so}(n_0)$ is a subalgebra, and excess $0$ at $n=8,10,12$, recomputed there against $\tfrac{n(n-1)}2-\dim\mathfrak{isotropy}$.

**The third-order condition is genuinely vacuous.** $T(z,z,z)=T(e,e,e)$ after the orbit split, and excess $0$ makes $e=0$, so the condition reads $0=0$.

**The fourth-order inequality is saturated, which is a different thing.** [second-order.md](../findings/second-order.md) states it: "wherever excess is $0$ it is an equality by the orbit identity". *So $\langle b,B^+b\rangle\le\theta/2$ holds with no slack at padded $W_{\mathbb{CP}^2}$, which is stronger news for F73 than vacuity, because a fourth-order test cannot be sharpened into a separator there.* **The post should say saturated rather than vacuous for the fourth order, and keep vacuous for the third.**

### C-reach, the class as worded closes the programme's own primary route

**F73's successor clause reads "A route to [I73](../plan.md) compares values across the critical set. It never proceeds from conditions at one point, at any order, because the competitor satisfies all of them."** Read literally that closes [I104](../plan.md), which proceeds from criticality, the block decomposition and bounds at a single critical point, and with it [I110](../plan.md) and [I111](../plan.md).

**What saves I104 is the stratum, and F73 does not mention it.** [r1059](REVIEW_r1059.md) records that padded $W_{\mathbb{CP}^2}$ carries ONE nonzero block, so it lies outside I104's two-block stratum, and the balanced sphere product is diagonal, so it lies outside as well. **The competitor satisfies every local condition and is not in the region I104 quantifies over.**

**So the class needs a restriction to be usable**: what is closed is a local condition that holds at EVERY critical point and is violated above $\sqrt{3/2}$. *A successor that carries a stratum hypothesis excluding padded $W_{\mathbb{CP}^2}$ is outside the class and should be recognised as such, and as worded it would not be.* **The post would also be the first thing a reader reaches for to kill I111, which it does not touch.**

## D, one correction landed and one refutes its own paragraph

### D1, the $\lvert c\rvert$ rewrite is right and reaches one of three copies

**Where it landed it is correct.** The [note](2026-09-14-I104-tau-positive.md)'s r1059 paragraph now reads "$\lvert c\rvert\ge0.575579$" with the parenthetical naming the forced shape's $\max(x,y,z)=0.288675$, and the conditions $x_i>0$ and equal $N_i$ follow in the next sentence, so the $0.00012$ pricing is scoped.

**Two copies of the old reading survive, and they are the two that state what a successor must do.**

- The same file, eleven lines on: "the requirement is a step that is LOSSY AT THE BINDING CORNER ITSELF, where the Gram bound saturates and $\max(x,y,z)\ge0.575579$". *The same sentence also calls the $x_i<0$ regime irrelevant "despite its $0.2505$", which the fold 136 lines later contradicts outright.*
- [2026-09-21-step8-position.md](2026-09-21-step8-position.md): "the Gram bound saturates at $u=\sqrt{5t/9}=0.438432$ at $t=0.346$ and $\max(x,y,z)\ge0.575579$ ... That single test kills every attempt made so far, including one worth $0.2505$ in a regime that is not binding."

**Both should read $\lvert c\rvert\ge0.575579$ with $\max(x,y,z)=0.288675$ at the forced shape**, and the second clause of each is now false rather than merely mis-symboled.

### D2, the $\pm(1,1,1)$ rewrite is correct and it refutes the paragraph it was inserted into

**The insertion is right.** $G_e$ has unit diagonal and off-diagonals $+\tfrac13$, so its top eigenline is $\pm(1,1,1)$, both signs attain, and [r1063](REVIEW_r1063.md) shows the corner takes the minus branch.

**The paragraph's conclusions were derived on the plus branch and are left standing in bold.** On the plus branch $x_i=\tfrac1{\sqrt3}$ and $y_i=z_i=-\tfrac1{2\sqrt3}$, so the shared-pair coefficient equals $\max(x,y,z)$ and step 8 is tight. **On the minus branch $x_i=-\tfrac1{\sqrt3}$ and $y_i=z_i=+\tfrac1{2\sqrt3}$, so the shared-pair coefficient is $-\tfrac1{\sqrt3}$ while $\max(x,y,z)=+\tfrac1{2\sqrt3}$, and step 8 is slack by $0.288675$ in shape units, $0.0192874$ in $F$'s.**

**Three sentences are therefore false as they stand**, all in the same paragraph as the correction.

- "But the gain vanishes exactly where the Gram bound is attained, and that is derivable."
- "So the shared-pair coefficient EQUALS $\max(x,y,z)$ there, and step 8 is tight at the same configuration."
- "The consequence is a localisation. Any gain from (ii) must come from configurations where the Gram bound is SLACK, since where it is attained both steps are simultaneously tight."

**The third is the exact negation of [I111](../plan.md).** I111 seeks a gain from step 8's second link at the corner, where the Gram bound SATURATES, and this paragraph says no gain lives there. *The two were committed on the same day and the earlier one was edited without being re-read.* **The repair is to scope the whole paragraph to the plus branch and to record the minus branch's $0.0192874$ as the gain that survives at Gram attainment**, which is also the number [I111](../plan.md) should be carrying.

## E, the bookkeeping, checked rather than reasoned about

**Clean.** Every `REVIEW_r*.md` file is linked from [INDEX.md](INDEX.md), $966$ index rows carry $966$ distinct ids and no duplicates, and the ids my first pass reported as missing are the grouped rows such as `| 60, 61 |`. *The one file without a row is this one, which the brief instructed me to leave alone.*

**The plan is consistent.** [I110](../plan.md) sits in DONE with its settlement text and appears elsewhere only as a link to `#done`. [I111](../plan.md) carries grade $\mathbf6$ in the section 1 grading table and a live entry beneath it.

**The trap index matches.** [INDEX-traps.md](../findings/INDEX-traps.md) row $73$ against [post F73](../findings/fence-posts.md), one of each. *Its summary repeats C2's misattribution and should be corrected with the post.*

**No dangling anchors in the touched files.** Nothing in the repository links to the replaced "I110'S SUBSTITUTION" heading by anchor, and the apparent failures in [plan.md](../plan.md) resolve through GitHub's slugger on headings such as "From [I2]", the case [r816](REVIEW_r816.md) documents, or through the explicit `<a id>` in [bounds.md](../findings/bounds.md).

**Two things to fix.**

- **[r1062](REVIEW_r1062.md)'s line anchor for `block_norms_agree` reads `#L281` and the declaration is now at line $285$**, moved by `411c67dd` expanding the docstring above it. Its other four line anchors still land: `chainF` at $68$, `deficit` at $77$, `deficit_at_sStar` at $258$, `coeff_at_uLo` at $271$.
- **[LEDGER.md](../findings/LEDGER.md) carries no entry for the r1062 and r1063 round, and none for F73's owed Gate 2**, while [plan.md](../plan.md) states that the ledger owns the Gate 2 debt and every landed verdict and is the only place either is written. *The plan's own Gate 2 section still reads "NOTHING IN FLIGHT as of 2026-09-19".*

## Reach

**What these findings ARE about.** The text of four commits, `02da1854`, `fe43b7f2`, `3bf41a4f` and `411c67dd`, read against [REVIEW_r1062.md](REVIEW_r1062.md), [REVIEW_r1063.md](REVIEW_r1063.md), [REVIEW_r1059.md](REVIEW_r1059.md), [L121](../findings/second-order.md), [L220](../findings/second-order.md), the R8 table in [second-order.md](../findings/second-order.md), and the two stored reference notes. Arithmetic throughout is on the corner the record already carries in radicals.

**What they are NOT about.** Nothing here reopens the exclusion. **The corner is excluded and both routes to it survive this reading intact**, the $P(q_a)$ flip and the $P(D)$ failure alike. Nothing here bears on unequal $N_a$, on $\tau<0$, on the derivation of the deficit's cubic, or on whether padded $W_{\mathbb{CP}^2}$ is a global competitor at any particular $n$. **Finding A1 changes the size of [I111](../plan.md)'s margin and not its sign**, and it says nothing about the surviving region, which is the quantitative question the item owns.

**What had only r1064 as a reader.**

- **The units correction, A1.** It is one multiplication, it rests on reading [r1059](REVIEW_r1059.md)'s own formula two paragraphs above the figure, and it changes a number the plan's primary item is built on, so it wants an independent check before [I111](../plan.md)'s text is rewritten.
- **The identification of $0.0192874$ as the corner's own gain**, which is [r1062](REVIEW_r1062.md)'s halved cap read as a route rather than as reinforcement.
- **That Corollary 3.1(i) reaches no odd-degree form**, one line from $f(-x)=-f(x)$.
- **That the R8 table's $B\vert_{W^\perp}\succeq0$ with excess $0$ is what makes padded $W_{\mathbb{CP}^2}$ a local maximum**, which is the load [F73](../findings/fence-posts.md) puts on Theorem 3.3.
- **That D2's paragraph contradicts [I111](../plan.md)**, found by reading the two texts side by side rather than by any computation.

**The recommendation, in order.** Rewrite the fold's route sentence around $0.0192874$ against $0.0148730$ and carry the same pair into [I111](../plan.md). Scope D2's paragraph to the plus branch. Re-point [F73](../findings/fence-posts.md) at the definition and the R8 table, and narrow its class with the stratum clause. The remaining items are wording and bookkeeping.
