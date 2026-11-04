# Gate 2, reviewer r171: the crux localisation and the $S=0$ Ansatz

Cold adversarial review of [plan.md](../plan.md) item 3 and item 3c, [bounds.md](../findings/bounds.md) fence post F17, [stratum-two-negative.md](../findings/stratum-two-negative.md), [response.md](../response.md) Lemma L35, and commits `319ec0a`, `64ae388`, `848c7e5`, `55818ba`. Deliverable: derivation. The $n\ge12$ plethysm was not run.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | the crux is the $\ge3$-negative stratum | **set is right, statement is not**, $\dim\mathfrak m$ is the negative-eigenvalue count with multiplicity, as the brief's primary attack asks; but "contains the $n=5$ maximiser" is circular and contradicts item 3c |
| 2 | the $S=0$ threshold Ansatz is dead | **right verdict, no valid reason given**, containment runs the wrong way, agreeing with reviewer 172; and separately the benchmark should be $\theta_0(n)$, not $\sqrt{3/2}$, against which $1.306498$ would close every $n\ge20$ |
| 3a | an ascent bounds a maximum from below | **correct, and still violated**, [plan.md:300](../plan.md#L300) says the opposite ten lines after the correction |
| 3b | $546\times$ larger, not $2809\times$ smaller | **verified exactly**, with one unreconciled tension |
| 3c | the orbit forces $45.9\%$ into $\ker G$ | **verified**, arithmetic and logic, conditional on the unproved $F\ge0$ |

---

## 1. The primary attack: does "$\dim\mathfrak m\le2$" mean "at most two negative eigenvalues"?

**It does, and the identification survives every test I could put to it.** This is the one place the brief asked me to look hardest, and the localisation is stated over the right set. *Reviewer 172 reached the same conclusion concurrently, and [plan.md:184](../plan.md#L184) now carries it; the derivation below was made independently and adds the mechanism argument, which is what makes the reading forced rather than merely consistent.*

**The definition is explicit and it is a count with multiplicity.** [bounds.md:49](../findings/bounds.md#L49) sets $\mathfrak m:=\mathrm{span}\{v_\alpha:\lambda_\alpha<0\}$, the negative eigenspace of $\mathring W$ acting on $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$. A subspace spanned by eigenvectors has dimension equal to the number of eigenvalues counted with multiplicity, so $\dim\mathfrak m$ is neither a block dimension nor an isotypic multiplicity. [Lemma L35](../response.md#L683) itself never writes $\mathfrak m$: its hypothesis reads "at most two negative eigenvalues, at any number of positive ones and any $m$", with roman $m$ the ambient dimension. The $\dim\mathfrak m\le2$ label is the shorthand of [plan.md:442](../plan.md#L442) and [stratum-two-negative.md](../findings/stratum-two-negative.md).

**The proof mechanism forces the multiplicity reading, which is the decisive check.** Lemma L35 needs the $(---)$ block of $\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ to be empty, and it is empty because $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ vanishes whenever two indices coincide, so three distinct indices cannot be found inside a $2$-dimensional space. Under a "two distinct negative values" reading a negative eigenvalue of multiplicity three would leave $(---)$ populated and the block would not vanish. So the hypothesis can only be the dimension of the negative eigenspace, and that is what the record uses.

**Independent numerical confirmation, built from the definitions.** I constructed $\mathfrak{so}(5)$ with $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$, formed padded $W_{\mathbb{CP}^2}$ from the self-dual basis of $\Lambda^2\mathbb R^4$, and measured: spectrum $(2,-1,-1,0^7)/\sqrt6$, $\|W\|^2=1$, $\mathop{\mathrm{tr}}W=0$, Ricci $=0$, first Bianchi $=0$, $\dim\mathfrak m=2$, and $\theta=\langle W^2+W^\#,W\rangle=1.2247448713915885$ against $\sqrt{3/2}=1.224744871391589$. The eigenframe identity $\theta=\sum\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$ reproduces the same value to the last bit. [LEDGER.md:69](../findings/LEDGER.md#L69) independently records $\dim\mathfrak m=2$ at this point once the kernel tolerance is applied.

**Two apparent discrepancies I chased and cleared before reporting them.**

- Lemma L35 states "row marginals $m-2$" while [bounds.md:191](../findings/bounds.md#L191) states $2(n-2)$. These are the same identity under different index conventions: $\sum_{\beta,\gamma}T_{\alpha\beta\gamma}=\|\mathop{\mathrm{ad}}v_\alpha\|_F^2=2(n-2)$, and $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=n-2$, the second form being the one [bounds.md:240](../findings/bounds.md#L240) uses explicitly. Measured: $6$ at $n=5$ and $8$ at $n=6$, exactly $2(n-2)$. Not an error, and inert either way since Lemma L35 drops the marginals.
- The pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$ reads as $1$ in the coordinate frame $\varphi_{ij}$, which I measured at $n=5,6$. It is attained at $2$ in padded $W_{\mathbb{CP}^2}$'s own eigenframe: $\theta=\sqrt{3/2}$ with $\sum\lambda^3=1/\sqrt6$ and $\lambda_1\lambda_2\lambda_3=2\cdot6^{-3/2}$ forces $T_{123}=2$ exactly. The cap is sharp where Lemma L35 uses it at equality.

### Defect 1, "contains the $n=5$ maximiser" is circular, and contradicts item 3c

Commit `55818ba` writes both halves of a contradiction. It establishes that *an ascent bounds a maximum from below*, hence "$\sqrt{3/2}$ is the best point found, not a proved maximum" at $n=5$; and it then asserts that Lemma L35's stratum "contains the $n=5$ maximiser (spectrum $(2,-1,-1,0^7)/\sqrt6$)". The second sentence names the ascent's top point as the maximiser, which is exactly what the first sentence says is unavailable. The true $n=5$ maximiser could lie in the $\ge3$-negative stratum, where nothing bounds it, that stratum is the open one.

**The record states the contradiction outright.** [plan.md:310](../plan.md#L310) lists among what a $\mathcal W_5$ certificate would establish "$\Theta_5=\sqrt{3/2}$, **which the record does not have**, only $n=4$ is proved". If the $\le2$-negative stratum contained the $n=5$ maximiser, then Lemma L35 plus the padded $W_{\mathbb{CP}^2}$ witness would give $\Theta_5=\sqrt{3/2}$ immediately. Item 3 and item 3c cannot both be right.

*Repair, one word:* the stratum contains the best $n=5$ point **found**.

### Defect 2, the complement is the crux only from $n=12$

Lemma L35's cap is dimension-free; its power to *exclude* is not. The exclusion needs $\sqrt{3/2}<\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, and I get $\theta_0(10)=1.200000$, $\theta_0(11)=1.219673$, $\theta_0(12)=1.236033$ against $\sqrt{3/2}=1.224745$, so from $n=12$, exactly as [stratum-two-negative.md](../findings/stratum-two-negative.md) states in its own lemma. [plan.md:184](../plan.md#L184) drops the qualifier (in its current form as much as in `848c7e5`) and converts a dimension-free *bound* into a dimension-free *exclusion*, which is false at $n\le11$. Harmless in practice, since item 3's target is $n\ge12$; wrong as written.

### Defect 3, the factor $2.07$ is an $n=5$ number carried to $n\ge12$

I reproduced it and it is right where it is derived. At $n=5$ the Lovelock collapse gives $\theta=3\mathop{\mathrm{tr}}(W^3)$; Okumura on trace-free symmetric $10\times10$ matrices gives $|\mathop{\mathrm{tr}}W^3|\le8/\sqrt{90}=0.8432740$ while $F_5\ge0$ demands $0.4082483=\sqrt{3/2}/3$, ratio $2.0656$. Okumura's extremiser is $(9,-1^9)/\sqrt{90}$, with **nine** negative eigenvalues, so the overshoot genuinely sits in the $\ge3$-negative stratum, at $n=5$. The transfer to $n\ge12$ is asserted, not shown: $\theta=3\mathop{\mathrm{tr}}(W^3)$ holds only for $n\le5$, and the record's own figure is that the two cubics already differ by $9.2\times10^{-2}$ at $n=6$.

### A result that strengthens claim 1, and shortens it at $n=5$

Maximising $p_3$ subject to $p_1=0$, $p_2=1$ over spectra with at most two negative entries gives exactly $1/\sqrt6$, attained at $(2,0^{N-3},-1,-1)/\sqrt6$, **free of $N$**. I verified this two ways: in closed form over two-block spectra, and by constrained SLSQP with $300$ restarts at $N=10$ and $N=15$, both returning $0.408248290464$ and the same argmax. Since $\theta=3\mathop{\mathrm{tr}}(W^3)$ at $n=5$, **Lemma L35's $\sqrt{3/2}$ on the $\le2$-negative stratum is at $n=5$ nothing more than this elementary spectral maximum**, two lines, no transportation relaxation, no dual weight, no interval arithmetic. Lemma L35's apparatus earns its keep from $n\ge6$ onward, where $\theta$ is not a function of the $\Lambda^2$ spectrum alone. Worth recording because the $n=5$ half of the localisation needs none of the contested machinery.

---

## 2. The Ansatz's retirement: right verdict, and the reason given was not one

**A note on concurrence.** Reviewer 172 landed `b8196cb` on this point while I was working, from a cold brief, and reached the containment argument independently; my section was written before I saw it. Where we agree I say so; the benchmark defect below is mine and is not in that commit.

**An LP optimum above a threshold is a statement about the relaxation, and the record says so two fence posts away.** [fence post F15](../findings/bounds.md#L283) records that "the relaxation is tight at the point that matters and **the whole overshoot sits at spectra that are not Weyl spectra**", and fence post F16 records that frame-realisability lies beyond any finite list of linear conditions. Containment runs Weyl $\subseteq$ LP-feasible, so a feasible point at $d=8$ exhibits no Weyl tensor. **The retirement recorded in `319ec0a` therefore proved nothing about the object the Ansatz was aimed at**, and [plan.md:194](../plan.md#L194) now says so.

**What the LP figure does refute is the Ansatz's literal wording, and only that.** `64ae388` asked for the least $k$ such that "$S=0$ **removes** every spectrum with $\ge k$ negative eigenvalues", removal from the LP's feasible set, which is the quantity fence post F17 measures. Read that narrowly, feasibility at $d=8$ kills every $k\le8$. Read as the thing the Ansatz was for (closing item 3), it is silent, and the honest kill is an exact witness: a Weyl tensor with $S_{\mathfrak{mmm}}=0$ and $d\ge3$, which is what [plan.md:196](../plan.md#L196) now supplies at $S^2\times S^3$, $n=5$, $d=6$, $\theta=0.942809$.

**The benchmark was also the wrong one, and that defect is still unrecorded.** The Ansatz's job is $\theta\le\theta_0(n)$, not $\theta\le\sqrt{3/2}$; $\sqrt{3/2}$ is Lemma L35's value, and the conjecture's threshold overtakes it at $n=12$. Computing the second crossover, $\theta_0(19)=1.302033<1.306498<\theta_0(20)=1.307670$. **So even taken at face value, an LP optimum of $1.306498$ would (if it held uniformly in $n$), close the conjecture at every $n\ge20$ and leave only $12\le n\le19$ open**, which is the opposite of what `319ec0a` concluded from it. The retirement measured a candidate bound against the wrong constant and happened to land on the right verdict.

**It does not hold uniformly, and that is the argument the comparison should have made.** $1.306498$ is an $n=6$ figure ($d=8$ of $N=\binom62=15$; the same paragraph works at $n=6$ with "twelve of fifteen eigenvalues negative"). Fence post F15 records the LP optimum growing with $n$, $1.722739$ at $n=6$ rising to $2.290283$ at $n=8$ on the marginals-only set, the overshoot going from $1.63\,\theta_0$ to $2.00\,\theta_0$. A quantity that outruns $\theta_0(n)$ cannot be beaten by waiting for $\theta_0$ to rise.

---

## 3. The three folded corrections, verified independently

### 3a. The ascent direction, correct, and violated ten lines later

The statement is right and needs no computation: a hill-climb returns a feasible value, hence a lower bound on a maximum. Commit `55818ba` records it as "written into the record twice".

**It is still in the record, a third time, inside the subsection that corrects it.** [plan.md:300](../plan.md#L300) reads: *"The nonnegativity itself comes from the ascent, which bounds the maximum from above; the screen cannot."* That is the corrected error verbatim, ten lines below [plan.md:290](../plan.md#L290) which corrects it. And line 290 is itself internally inconsistent, concluding "So $\tfrac32\|W\|^6-\langle Q(W),W\rangle^2\ge0$ on $\mathrm{Weyl}_5$" (an upper bound on $\max\theta$), three clauses before "So $\sqrt{3/2}$ is the best point found, not a proved maximum".

**The direction error does not infect claim 2.** There the LP figure is used as a *lower* bound on an optimum that must be shown to exceed a threshold, which is the direction a search can deliver, and an LP solved by simplex returns the exact optimum in any case.

### 3b. $546\times$ larger, not $2809\times$ smaller, verified exactly

Every figure reproduces from $\dim\mathrm{Weyl}_n=\tfrac1{12}(n+2)(n+1)n(n-3)$:

| quantity | value | check |
|---|---|---|
| $\dim\mathrm{Weyl}_{12}$ | $1638$ | $14\cdot13\cdot12\cdot9/12$ |
| earlier attempt's Gram, $n=12$, full space | $\binom{1640}2=1\,343\,980$ | ATTEMPTS' "$\sim1.34\times10^6$", degree-$\le2$ monomials |
| 3c's unreduced Gram | $\binom{1640}3=733\,813\,080$ | the "$734$ million" |
| ratio | $\binom{1640}3/\binom{1640}2=1638/3=\mathbf{546}$ | exact, not rounded |
| the retracted figure | $1.34\times10^6/477=2809.2$ | reduced parameters against an unreduced Gram |

So the original comparison mismatched twice at once (a reduced count against an unreduced dimension, and degree six against degree four) and the correction is sound.

**One tension the correction leaves standing.** "3c's problem is $546\times$ larger" is true in unreduced units, and unreduced units are exactly what the block decomposition exists to avoid; [plan.md:282](../plan.md#L282) simultaneously reports the reduced SDP at $477$ unknowns against $89$ constraints. Both live in plan.md unreconciled. The defensible statement is the narrower one, and it is the one that bites: **the $734$ million is 3c's own Gram, so dismissing it as "a space the certificate never touches" is valid only conditional on the isotypic projection**, which [plan.md:302](../plan.md#L302) says does not exist, in its own words "the gap between 'the SDP is small', which is established, and 'the SDP is posed', which is not".

### 3c. The orbit constraint, verified, and conditional on what 3c wants to prove

Arithmetic reproduces: $\dim\mathrm{Weyl}_5=35$, $\dim\mathrm{Sym}^3=\binom{37}3=7770$, $7770-3570=4200$, $3570/7770=45.946\%$.

Logic holds. Writing $F(W)=v(W)^\top Gv(W)$ with $v$ the cubic Veronese and $G\succeq0$, $F\ge0$ together with $F(W_0)=0$ gives $Gv(W_0)=0$; $O(5)$-invariance carries that to the whole orbit, so the orbit-evaluation span sits in $\ker G$ and $\mathop{\mathrm{rank}}G\le4200$. The trivial-block forcing also holds: the invariant cubic space is one-dimensional at $n=5$ by the Lovelock syzygy, spanned by $\mathop{\mathrm{tr}}(W^3)$, and I measured $\mathop{\mathrm{tr}}(W_0^3)=\sum\lambda^3=1/\sqrt6\ne0$, so a $1\times1$ PSD block with nonzero evaluation is forced to zero.

**Two caveats.** The obstruction is conditional on $F\ge0$ on $\mathrm{Weyl}_5$, which is precisely what is unproved (defect 1 above), a sound conditional, since infeasibility of $F\ge0$ would kill the certificate anyway, but it should be stated. And the operative conclusion, if $F\ge0$ holds and the low end is genuinely over-determined, is **that a degree-$3$ SOS is inadequate**, Hilbert non-representability, which plan.md already flags as "non-automatic by Hilbert". I could not verify the $14$-constraint figure or the exact integer search without the script; the "$9$ to $56$" range is too wide to decide the question either way.

---

## Answers to the three questions

**(a) Nothing is asserted as new that the record already holds.** `848c7e5` is labelled `docs` and its own body concedes it restates ("worth more than 'the non-diagonal half'"); the substance is already at [FINDINGS.md:26](../FINDINGS.md#L26), [plan.md:442](../plan.md#L442) and [bounds.md:277](../findings/bounds.md#L277). The Ansatz of `64ae388` was genuinely absent as a question; its refutation was not, $1.306498$ was already indexed by name at [FINDINGS.md:86](../FINDINGS.md#L86).

**(b) Yes, $6$ is right, and the file disagreed with itself about it until this cycle.** The rubric table at [plan.md:81](../plan.md#L81) grades 3c as $3\times2\times1=\mathbf6$, attackable $=2$, annotated "sub-step 1 done, but the $n\ge12$ projection is unpriced". The section heading at [plan.md:256](../plan.md#L256) read "grade $3\times3\times1=9$" from ffe5004 until `b8196cb` brought it to $6$ mid-review. **$6$ is the defensible figure and the repair was right.** [plan.md:302](../plan.md#L302) says the SDP is not posed, and reviewer 170's orbit result is evidence *against* feasibility, so attackable cannot rise from $2$ to $3$; if anything the orbit result argues the score should be revisited downward once the "$9$ to $56$ parameters against $14$ constraints" range is narrowed.

**(c) The structural feature is adjudication, not retrieval, and the record already proves it.**

*The size is real but it is not the cause.* The six core files carry $\approx239{,}000$ words over $9{,}357$ lines, alongside $102$ committed reviews.

*Two pieces of evidence that retrieval worked and judgement failed.*

- `64ae388`'s own commit body names the line that killed it: *"not the LP bound at bounds.md line 199, which reaches $1.306$ and is a different quantity"*. [bounds.md:199](../findings/bounds.md#L199) is exactly the line `319ec0a` then used to retire the proposal. The screen reached the right line and dismissed it with "a different quantity" without naming the quantity.
- [FINDINGS.md:86](../FINDINGS.md#L86) already carries a numeric index, and $1.306498$ is in it, explicitly labelled a linear-programming optimum. The index fired and the proposal died anyway, because the index carries the number's *category* and not the *claim it refutes*.

*So `319ec0a`'s diagnosis is wrong.* "The screen was one sentence deep and needed to be one section deep" is a retrieval diagnosis for an adjudication failure, and the lesson drawn from it will not prevent the next death.

*The cheap fix is two edits to files already open every cycle.*

1. **Give FINDINGS.md's number index a third column: the claim the number kills.** For instance, *$1.306498$: LP optimum at $n=6$ with $R\lambda=-2\lambda$ and $S=0$ imposed, attained at $d=8$; refutes any argument that $S=0$ empties the many-negative stratum at a threshold $k\le8$.* The number is already indexed; only the verdict is missing.
2. **A screen that dismisses a record item must quote it and name the distinction in one sentence.** "A different quantity" without saying which quantity is not a screen, and it is what was written the one time the correct line was found.

---

## What I checked and did not run

Sage's $n\ge12$ plethysm was not invoked. All numerics are $n\le6$ `numpy`/`scipy`, seconds of wall clock: the $\mathfrak{so}(n)$ structure constants and $T$ marginals at $n=5,6$; padded $W_{\mathbb{CP}^2}$ built from the self-dual frame, with unit norm, tracelessness, Ricci-flatness, first Bianchi and $\theta$ all confirmed; the eigenframe cubic identity; and the constrained maximisation of $p_3$ over the $\le2$-negative stratum at $N=10,15$.

