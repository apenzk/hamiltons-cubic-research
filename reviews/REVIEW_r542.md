# REVIEW_r542, Lemma L72

**Target:** Lemma L72, "the rank-3 stratum is overdetermined, and its converse clause closes in three lines", in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) at the `#### Lemma L72` heading (line 492), through to the next heading.

**Reviewer:** r542, independent adversarial audit, cold. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts were run, and none were needed, every check below is hand algebra against [conventions.md](../findings/conventions.md).

**VERDICT: REFUTED**, scoped in one line: *the numbered forward implication is correct and I re-derived it cold; the block's second claim, that L72 closes [Lemma L29](../findings/stratum-two-negative.md)'s converse clause and is "stronger than the clause", is false, and it sits inside the boxed LEMMA text and has propagated to four other places in the record.*

| the block's claim | verdict |
|---|---|
| every critical point of the $(1,2)$ stratum has spectrum $(2,-1,-1)/\sqrt6$, $\theta=\sqrt{3/2}$, every $n$, no numerics, no case analysis | **CONFIRMED**, re-derived independently; also $T=2$ |
| the three rows are the right three, and the algebra from them | **CONFIRMED** |
| "overdetermined" | **earned only under an unstated counting convention**, square under the natural one |
| L72 closes L29's converse clause | **REFUTED**, hypothesis substitution: L72 quantifies over *critical points*, the clause over *equality points* |
| "the closure is stronger than the clause … not merely at equality" | **REFUTED**, the containment runs the other way |
| "$T=0$ fails (ii) outright" | **false as written**; the conclusion survives via (i) |
| "the only bracket entry the rows see is $T$" | **true of the three non-kernel rows only**; harmless, but the $N-3$ kernel rows are dropped without comment |
| the Bianchi paragraph's identity $\sum_{\alpha\ne\beta}\lambda_\alpha\epsilon_{\alpha\beta}=0$ | **CONFIRMED**, re-derived from L33's operator identity |
| that paragraph "replac[es] the Ricci-PSD support argument, the descent to $r=4$ and the $\mathfrak{su}(2)$ input" | **overstated**, it gives the marginals, not the localisation $\theta=f(t)$ needs |

## Conventions fixed first

Against [conventions.md](../findings/conventions.md), before touching the block:

- **"Critical point" is $Q(W)=\theta W$** with $Q(W)=W^2+W^\#$. In an eigenframe this is diagonal, so row $\beta$ reads $(W^\#)_{\beta\beta}=\lambda_\beta(\theta-\lambda_\beta)$, the block's row equation is exact, not an approximation.
- **$T_{abc}=c_{abc}^2$** with $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric. So $T\ge0$ and $T$ vanishes on repeated indices.
- **The pair sum inside $W^\#$ is UNORDERED.** conventions.md says pair sums are ordered unless stated, but the anchor $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ forces the unordered reading here: $\sum_{\gamma<\delta}T_{\beta\gamma\delta}=\tfrac12\sum_\gamma\lVert[v_\beta,v_\gamma]\rVert^2=n-2$. Under the ordered reading every row would carry a spurious factor $2$ and the block's $(W^\#)_{11}=Tab$ would be $2Tab$. **The block is in the right normalisation**; it does not say which, and this is exactly the class of collision conventions.md exists to prevent.
- Unit norm is $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$, so $6a^2=1$ is right.
- Pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$; deficit $\epsilon_{\alpha\beta}=2-\lVert[v_\alpha,v_\beta]\rVert^2\ge0$.

Cross-check against [bounds.md:233](../findings/bounds.md#L233): the record's per-index relation (C), $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$, is the block's row halved into unordered form. Agreement.

## Q1, is the parent's derivation the block's argument, and is it right?

**The parent's derivation is correct algebra, but it is not the block's, and it imports a hypothesis the block does not need.**

Both routes start the same way. Subtracting (iii) from (ii):

$$-T\lambda_1(a-b)=(a-b)(\theta+a+b)\quad\Longrightarrow\quad (a-b)\bigl(T\lambda_1+\theta+a+b\bigr)=0,$$

exactly as the parent has it. The parent then kills the second factor by positivity, which needs $\theta>0$.

**The block does not do that.** Its second branch is $T\lambda_1=-(\theta+a+b)$ fed back into (ii):

$$-(\theta+a+b)b=a(\theta+a)\ \Longrightarrow\ \theta(a+b)=-(a^2+ab+b^2)\ \Longrightarrow\ \theta=-\frac{a^2+ab+b^2}{a+b},$$

which is the block's printed branch value, and then $\theta+a=-b^2/(a+b)$ and (ii) give $T\lambda_1=-ab/(a+b)$, so $T=-ab/(\lambda_1(a+b))<0$ against $T=c^2\ge0$. **Every constant the block prints on that branch checks out.** No sign of $\theta$ is used anywhere.

So: one argument in the block, sound, and strictly better than the parent's because it needs no $\theta>0$. The parent's is also sound *given* $\theta>0$, the error is only that $\theta>0$ is neither stated in the block nor available as a hypothesis.

The rest, re-derived cold with $a=b$: tracelessness $\lambda_1=2a$; row (i) $Ta=2\theta-4a$; row (ii) $2Ta=\theta+a$; eliminating $Ta$ gives $4\theta-8a=\theta+a$, so $\theta=3a$ and $T=2$; unit norm $6a^2=1$ gives $a=1/\sqrt6$, spectrum $(2,-1,-1)/\sqrt6$, $\theta=3/\sqrt6=\sqrt{3/2}$. **Confirmed.**

*Independent screen of the answer against a different identity.* The file's own cubic identity $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ evaluated on the solution: $\sum\lambda^3=(8-1-1)/(6\sqrt6)=1/\sqrt6$ and $3\cdot2\cdot(2/\sqrt6)(1/\sqrt6)(1/\sqrt6)=2/\sqrt6$, total $3/\sqrt6=\sqrt{3/2}$. Agrees, by a route the rows do not use. (Hand arithmetic; no computation run.)

## Q2, where $T\ge0$ comes from

**It is a theorem of the setting, not an assumption, and the block names it correctly but does not source it.**

conventions.md: *"Structure constants $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are totally antisymmetric … so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide."* $T$ is a square of a real number in an orthonormal eigenframe; nonnegativity is definitional. The block writes *"impossible for $T=c^2$"*, which is the right reason stated in the right place. It carries no pointer to [conventions.md](../findings/conventions.md), which the record's own quote-never-restate rule asks for, but nothing is wrong.

**Defect, minor: "and $T=0$ fails (ii) outright" is false as written.** $T=0$ in (ii) gives $0=a(\theta+a)$, i.e. $\theta=-a$, an equation, not a failure. What kills $T=0$ is row (i): $0=\lambda_1(\theta-\lambda_1)$ with $\lambda_1>0$ forces $\theta=\lambda_1>0$, contradicting $\theta=-a<0$. The clause is also **superfluous**: nothing in the branch elimination divides by $T$, so the case never needed separating.

## Q3, does the block need $\theta>0$?

**No, and it correctly does not claim it. The block's only stated hypothesis, "at a critical point" plus $a,b>0$, is sufficient.**

- The block's route uses only $\lambda_1>0$, $a,b>0$, $T\ge0$. $\theta>0$ is a *conclusion*: $\theta=3a>0$.
- **So the block proves there is no $\theta<0$ critical point in this stratum**, the $\theta<0$ case is not a hole, it is excluded by the same three lines.
- **The $e(-W)=e(W)$ style worry does not reach here.** $Q$ is quadratic, so $Q(-W)=Q(W)$ and $-W$ is critical with multiplier $-\theta$. But $W\mapsto-W$ sends spectrum $(\lambda_1,-a,-b)$ to $(-\lambda_1,a,b)$, i.e. it maps this stratum to the *two-positive-one-negative* stratum. It produces mirror critical points with spectrum $(1,1,-2)/\sqrt6$ and $\theta=-\sqrt{3/2}$ there, and **no** counterexample inside the $(1,2)$ stratum. The scope claim is safe in a way L29's neighbouring one was not.
- The block never writes $\lambda_1>0$ in the working line, only the boxed statement's "exactly one positive" supplies it. It is used twice (branch sign, and killing $T=0$).

## Q4, is "overdetermined" earned?

**Under the parent's counting, no: the system is square. Under the block's own counting, yes, but the block never says which unknowns it is counting, and the two answers differ.**

*Parent's counting.* Unknowns $(\lambda_1,a,b,T,\theta)$: five. Normalisations $\operatorname{tr}W=0$ and $\lVert W\rVert=1$: two. Three freedoms left, three rows, **square**, and a square system generically has an isolated solution, which is precisely what comes out. Nothing is over-constrained in this reading.

*The block's counting*, given in the "Why this stratum and no other" paragraph: hold the spectrum and $\theta$ fixed, take $T$ as the unknown. Then at rank $r$ there are $r$ rows against $\binom r3$ live entries: $3$ vs $1$ at $r=3$ (overdetermined), $4$ vs $4$ at $r=4$, $5$ vs $10$ at $r=5$. The arithmetic is right and the crossing is where the block says it is.

Two caveats on that paragraph:

- **"determined at rank 4" is not established.** Four equations in four unknowns are determined only if the $4\times4$ system is invertible, which is not shown; and if $\theta$ is counted as unknown (as it must be if it is unknown at rank 3) the rank-4 count is $4$ equations in $5$ unknowns, i.e. *under*determined. The paragraph switches convention between the two ranks.
- **It counts one of the record's three per-index relation families.** [bounds.md:233](../findings/bounds.md#L233) records (A) $\sum T_{k\beta\gamma}=2(n-2)$, (B) $\sum\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$ and (C) the row used here. (A) and (B) also hold at every index. They do not change the live-entry count (they reach entries with kernel indices) but "the rows give $r$ equations" is one third of the row calculus, not all of it.

**Verdict on the word:** defensible, under a convention the block owes the reader and does not give.

## Q5, rank and kernel bookkeeping

**The three non-kernel rows are the right three, and their claim about $T$ is right *for them*. The block's blanket sentence is not, and it silently drops $N-3$ equations, which turn out to be automatically satisfied, so the lemma stands.**

The block says: *"the only bracket entry the rows see is $T:=T_{1,N-1,N}$"*.

- **True for $\beta\in\{1,N-1,N\}$.** Row $1$: $(W^\#)_{11}=\sum_{\gamma<\delta}T_{1\gamma\delta}\lambda_\gamma\lambda_\delta$, and $\lambda_\gamma\lambda_\delta\ne0$ needs $\{\gamma,\delta\}=\{N-1,N\}$, giving $T\cdot(-a)(-b)=Tab$. Row $N-1$: $T\lambda_1(-b)=-a(\theta+a)$, i.e. (ii). Row $N$: (iii). All three signs check.
- **False for the $N-3$ kernel rows.** For $\lambda_\kappa=0$ the row reads $0=(W^\#)_{\kappa\kappa}=-\lambda_1a\,T_{\kappa,1,N-1}-\lambda_1b\,T_{\kappa,1,N}+ab\,T_{\kappa,N-1,N}$, three *different* bracket entries per kernel index. These are genuine equations of the criticality system and the block does not mention them.
- **They are harmless, and here is why the block gets away with it.** The rows force $T_{1,N-1,N}=2$, which saturates the pair cap on all three support pairs, so $T_{1,N-1,\gamma}=T_{1,N,\gamma}=T_{N-1,N,\gamma}=0$ for every $\gamma$ outside $\{1,N-1,N\}$. Every kernel row then reads $0=0$. The same saturation kills every off-diagonal entry of $W^\#$, so $Q(W)=\theta W$ holds in full, not merely on the diagonal. **The dropped equations close, but the block never checks that they do**, and the check runs backwards through the conclusion rather than forwards, worth stating in the block.
- **The rank-3 solution is exactly at the boundary of the feasible set.** $T=2$ meets the pair cap $\le2$ with no slack; had the rows returned $T>2$ the lemma would have been vacuous rather than sharp. Row marginal (A) at $\beta=1$ needs $n-2\ge2$, so $n\ge4$, the whole range where $\mathcal W_n\ne0$. "For every $n$" holds.

## Q6, the converse clause. This is where the block breaks.

**The clause is genuinely closed. L72 is not what closes it, and the block's claim to be "stronger than the clause" inverts the containment.**

### What the clause actually is

[stratum-two-negative.md:35](../findings/stratum-two-negative.md#L35), "The equality clause, reduced but open", verbatim:

> The argument gives equality $\Rightarrow$ spectrum $(2,-1,-1)/\sqrt6$; the converse needs that no other configuration attains $\sqrt{3/2}$. The bracket-cap characterisation forces $\mathrm{im}\,v_2=\mathrm{im}\,v_3$ of dimension $4$, hence $r=4$, so the *iff* is **equivalent to**: no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ exists for even $r\ge6$.

So the open item is a statement about **configurations attaining equality**, and the numerics at $r=6,8,10$ that the block promises to replace are numerics about **realisability of full-support rank-3 elements**. Neither is a statement about critical points.

### The broken step

L72's hypothesis is **"critical point"**, $Q(W)=\theta W$. The clause's hypothesis is **"$\theta(W)=\sqrt{3/2}$ within the stratum"**. Substituting one for the other is the defect.

- A point maximising $\theta$ over the stratum is critical **along the stratum only**. The stratum is not open in $\{\lVert W\rVert=1\}$ (its $N-3$ zero eigenvalues lift under generic perturbation) so stratum-maximality does not give $Q(W)=\theta W$.
- **At $n\ge12$ it demonstrably cannot be recovered**, because $\sqrt{3/2}<\theta_0(n)$ there (the file's own table: $1.224745$ against $1.236033$ at $n=12$). An equality point is then not a global maximiser of $\theta$ on $\mathcal W_n$, so criticality cannot be inferred from maximality by any route.
- **And the containment runs the other way.** By L29 plus L72, every critical point of the stratum has $\theta=\sqrt{3/2}$, i.e. $\{\text{critical}\}\subseteq\{\text{equality}\}$. A statement quantified over critical points is therefore **weaker**, not stronger. The block's

  > and the closure is stronger than the clause: the spectrum is forced at *every* critical point of the stratum, not merely at equality

  asserts $\{\text{critical}\}\supseteq\{\text{equality}\}$. **That is backwards, and no argument for it exists in the record.**

### What does close it, three lines, in the same file, 100 lines above

Take $W$ in the stratum with $\theta=\sqrt{3/2}$.

1. Equality in L29's chain $\theta\le\operatorname{tr}W^3+6\lambda_1ab$ forces $3T_{1,N-1,N}\lambda_1ab=6\lambda_1ab$, so $T_{1,N-1,N}=2$; then $\lVert[v_2,v_3]\rVert^2\ge T_{1,N-1,N}=2$ and the cap gives $\lVert[v_2,v_3]\rVert^2=2$.
2. [Lemma L31](../findings/stratum-two-negative.md#L391), *"$\lVert[X,Y]\rVert^2=2$ if and only if $XY=-YX$, both $X$ and $Y$ have rank $4$ with all singular values $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y$"*, gives $\mathrm{im}\,v_2=\mathrm{im}\,v_3$ of dimension $4$.
3. L29's Ricci-flatness identity $\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$ gives support $=\mathrm{im}\,v_1=\mathrm{im}\,v_2+\mathrm{im}\,v_3$, so $r=4$; there the stratum is the self-dual family $W^+=\mathrm{diag}(q+r,-q,-r)$ and equality forces $q=r$, i.e. padded $W_{\mathbb{CP}^2}$.

**No criticality, no numerics, no case analysis, every $n$.** [Lemma L33](../findings/stratum-two-negative.md#L117) closes the same item by a second route, its own statement carries *"In particular no rank-$3$ $\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector"*, which is verbatim the reduction the block promises to replace.

So the closure is real and the record already held it twice over. **The credit is misassigned to L72**, and the numerics the block claims to retire were retired by L31/L33, not by the criticality rows.

### Where the misattribution has propagated

| location | text |
|---|---|
| [stratum-two-negative.md:82](../findings/stratum-two-negative.md#L82) | L29's canonical statement: converse *"is closed by Lemma L72 below"* |
| [results.md:414](../results.md#L414) | *"The converse … is Lemma L72"* |
| [results.md:767](../results.md#L767) | *"closing the converse clause of Lemma L29 by the criticality rows alone"* |
| [INDEX-results.md:44](../findings/INDEX-results.md#L44) | *"The equality clause is closed by L72, not hedged on numerics"* |
| [LEDGER.md:622](../findings/LEDGER.md#L622) | *"Lemma L72 closes it 432 lines below at every $n$"* |
| [REVIEW_r513.md:152](REVIEW_r513.md), [REVIEW_r514.md:118](REVIEW_r514.md) | both graded the claim *"as stated"* |

Two earlier reviewers passed it. [r513](REVIEW_r513.md) re-derived L72's algebra but wrote *"Setting $a=b$"*, it never audited the branch step, and it never compared the two hypotheses.

**And the same file still disagrees with itself in three places**: line 13 says the converse is *"reduced but not closed"*, line 35 says *"reduced but open"*, line 82 says *"closed by Lemma L72"*.

## The block's last paragraph, one confirmed identity, one overstatement

**Confirmed, re-derived cold.** Pairing L33's identity $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$, $N_v=2v\otimes v-\mathrm{ad}(v)^2$, against $v_\beta$ gives $\langle N_{v_\alpha}v_\beta,v_\beta\rangle=2\delta_{\alpha\beta}+\lVert[v_\alpha,v_\beta]\rVert^2$, hence $2\lambda_\beta+\sum_\alpha\lambda_\alpha\lVert[v_\alpha,v_\beta]\rVert^2=0$; substituting $\lVert[v_\alpha,v_\beta]\rVert^2=2-\epsilon_{\alpha\beta}$ with $\operatorname{tr}W=0$ and $\epsilon_{\beta\beta}=2$ leaves exactly

$$\sum_{\alpha\ne\beta}\lambda_\alpha\epsilon_{\alpha\beta}=0 .$$

This is relation (B) of [bounds.md:233](../findings/bounds.md#L233) in $\epsilon$ coordinates, I checked the two agree by expanding (B) at $k=1$ on this stratum. Row $\beta=1$ then gives $-a\epsilon_{1,N-1}-b\epsilon_{1,N}=0$ with $\epsilon\ge0$, so both vanish; row $N$ gives $\lambda_1\epsilon_{1,N}-a\epsilon_{N-1,N}=0$, so the third vanishes. **All three steps correct.** The added-rows identity is correct too: rows $N-1$ and $N$ summed give $\sum_p\lambda_p(\epsilon_{p,N-1}+\epsilon_{p,N})=(a+b)\epsilon_{N-1,N}$, which is the printed $\sigma\delta$ **provided** $\sigma=a+b$ and $\delta=\epsilon_{N-1,N}$, neither symbol is defined in the block.

**Overstatement.** The block says these rows replace *"the Ricci-PSD support argument, the descent to $r=4$ and the $\mathfrak{su}(2)$ input"*. They do not. What they deliver is saturation of the three **marginals** $\lVert[v_\alpha,v_\beta]\rVert^2=2$. What L29's identity clause needs is $T_{1,N-1,N}=2$ specifically (the mass localised on the support triple) and the marginal is equally consistent with $T_{1,N-1,\kappa}=2$ for a kernel index $\kappa$, which contributes nothing to $\theta$. The localisation is exactly what the $r=4$/$\mathfrak{su}(2)$ route supplies (or, alternatively, what L31 supplies from the saturated marginal). **The three lines are a real improvement and they are not a replacement.**

## What I did not do

- Did not open [ELIM-stratum.md](ELIM-stratum.md), the block's cited provenance, or any PDF or script, per brief.
- Did not read r541's log or report.
- Ran no computation. The one numerical statement above ($\theta=\sqrt{3/2}$ from the cubic identity) is hand arithmetic on exact surds, offered as a consistency screen, not as evidence.

## What would have to change

1. **Cut the second sentence of the boxed LEMMA and the second half of the heading.** The lemma is the forward implication; it is true, clean and worth its number.
2. **Reattribute the converse clause to [L31](../findings/stratum-two-negative.md#L391) (and independently [L33](../findings/stratum-two-negative.md#L117))**, with the three lines above, and fix the five downstream citations.
3. **Reconcile lines 13, 35 and 82** of [stratum-two-negative.md](../findings/stratum-two-negative.md), which currently give three different statuses for the same clause.
4. **State the normalisation** (unordered pair sum in $W^\#$), **note the kernel rows and why they close**, drop the false "$T=0$ fails (ii) outright", and name the counting convention behind "overdetermined".

**VERDICT: REFUTED**, the numbered forward implication is confirmed and re-derived cold; the block's converse-closure claim, which sits inside the boxed lemma text and in the heading, is false by hypothesis substitution and by an inverted containment.
