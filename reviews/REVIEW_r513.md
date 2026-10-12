# Review r513, Lemma L29

**Target:** Lemma L29, "one positive and two negative eigenvalues cap $\theta$ at $\sqrt{3/2}$", in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) at the `#### Lemma L29` heading (line 69), down to the next heading.

**Reviewer:** r513, cold brief, analysis-only footing (no searches, sweeps, censuses; screening only).

## Phase plan

0. Fix conventions against the record's anchors ($Q_{ab}$, $\operatorname{tr}W^\#=-1$, $\theta_0(6)=\sqrt{10}/3$, $\dim\mathcal W_n$).
1. Read L29 verbatim.
2. Attack the hypothesis wording (the L33 multiplicity defect).
3. Attack the constant and its normalisation ($\sqrt{3/2}$ vs $\sqrt3/2$).
4. Attack sharpness at padded $W_{\mathbb{CP}^2}$.
5. Derive the $c'$ antisymmetry / $\dim\mathfrak m\le2$ vanishing claim and the vacuity consequence for R2.
6. Check dimension-freeness and padding.
7. Grep the 11 citations; classify each as cap-as-stated or strengthening.
8. Grep findings/ for restatements; check later sections of the same file.
9. Check the provenance line against git.
10. Verdict.

**VERDICT: CONFIRMED**, see the verdict section at the end.

---

## Phase 0, anchors, re-derived cold

All four anchors reproduce, and they pin the normalisation L29 is written in.

| anchor | check | result |
| --- | --- | --- |
| $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ | $n=4\Rightarrow 4\cdot1\cdot5\cdot6/12=10$ | holds |
| $\theta_0(6)=\sqrt{10}/3$ | $\theta_0^2=2\cdot5\cdot4/36=10/9$ | holds |
| $\operatorname{tr}W^\#=-1$ | with $\langle W,W^\#\rangle=\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ and $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2=2-\epsilon_{\alpha\beta}$: $\operatorname{tr}W^\#=\tfrac12\sum_{\gamma\ne\delta}(2-\epsilon)\lambda_\gamma\lambda_\delta=\tfrac12\big[2((\sum\lambda)^2-\sum\lambda^2)-\sum\epsilon\lambda\lambda\big]=\tfrac12(-2-0)=-1$ | holds, and it **certifies the $\tfrac12$ in L29's expansion** |
| bracket normalisation | $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$ gives $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, norm-squared $1$ | matches the file's own "norm $1$" remark, so the file is in $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ |

The $\operatorname{tr}W^\#=-1$ derivation is the load-bearing one: it uses the file's own $\epsilon$-identity $\sum_{\alpha\ne\beta}\epsilon_{\alpha\beta}\lambda_\alpha\lambda_\beta=0$ and the pair cap, and it returns $-\lVert W\rVert^2$ only if the expansion carries $\tfrac12$ and the pair cap is $\le2$ (not $\le1$). L29's two normalisation-sensitive ingredients are therefore mutually consistent with the record.

## Phase 1–3, the proof's algebra, re-derived line by line

Every step of the canonical proof reproduces.

- **$P=\operatorname{tr}W^3+\langle W,W^\#\rangle$.** With eigenvalues $(\lambda_1,-a,-b,0,\dots,0)$, $\operatorname{tr}W^3=\lambda_1^3-a^3-b^3$ exactly. Correct.
- **$\lambda_1=a+b$.** Ricci-flatness is $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$ on $\mathbb R^n$ (using $v^2=-vv^{\mathsf T}$ for skew $v$); its trace, with $\operatorname{tr}(v_\alpha v_\alpha^{\mathsf T})=2$ for each unit $v_\alpha$, gives $2\lambda_1=2a+2b$. Correct, and consistent with the weaker $\operatorname{tr}_{\Lambda^2}W=0$.
- **Then $\operatorname{tr}W^3=(a+b)^3-a^3-b^3=3ab(a+b)=3\lambda_1ab$**, so $P\le 3\lambda_1ab+6\lambda_1ab=9ab(a+b)$, which is the file's $\theta=9qr(q+r)/\lVert W\rVert^3$.
- **The $(+--)$ count.** Six ordered triples with distinct entries $\{1,N-1,N\}$, each contributing $T_{1,N-1,N}\lambda_1ab$; times $\tfrac12$ gives $3T_{1,N-1,N}\lambda_1ab$. Correct.
- **Unit norm.** $(a+b)^2+a^2+b^2=1\iff a^2+ab+b^2=\tfrac12$. With $b=ta$, $a=1/\sqrt{2(t^2+t+1)}$.
- **The closed form.** $9t(1+t)a^3=\dfrac{9t(t+1)}{2^{3/2}(t^2+t+1)^{3/2}}=\dfrac{9\sqrt2\,t(t+1)}{4(t^2+t+1)^{3/2}}$, **exactly the printed $f(t)$**.
- **The stationary point.** $(\log f)'=\frac1t+\frac1{t+1}-\frac32\frac{2t+1}{t^2+t+1}=(2t+1)\big[\frac{1}{t^2+t}-\frac{3}{2(t^2+t+1)}\big]$, zero on $t>0$ iff $t^2+t=2$, i.e. $t=1$. **Unique, as claimed.** $f$ is also invariant under $t\mapsto1/t$, so the restriction $t\ge1$ forced by $a\le b$ loses nothing.
- **The value.** $f(1)=\dfrac{18\sqrt2}{4\cdot3\sqrt3}=\dfrac{\sqrt6}{2}=1.224745=\sqrt{3/2}$.

**Finding 1 (no defect): the constant is the un-deflated $\sqrt{3/2}=1.2247$, and the block is internally consistent about it.** $f(1)=\sqrt6/2$ is $\sqrt{3/2}$, not $\sqrt3/2=0.8660$. The cross-check the block itself draws ("$\sqrt{3/2}<\theta_0(n)$ from $n=12$"), confirms the normalisation independently: $\theta_0(11)^2=180/121=1.4876<1.5$ and $\theta_0(12)^2=220/144=1.5278>1.5$, so the crossover is at exactly $n=12$. Under the deflated reading the crossover would be nowhere near $n=12$. **The documented trap is absent here.**

## Phase 4, sharpness at padded $W_{\mathbb{CP}^2}$: verified two independent ways, and the cap is **attained**

**The spectrum.** $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, so *any* trace-free symmetric operator on the $3$-dimensional $\Lambda^+$ with $W^-=0$ is a genuine $\mathrm{Weyl}_4$ element. $(2,-1,-1)/\sqrt6$ has $\sum\lambda=0$ and $\sum\lambda^2=6/6=1$, and $\lambda_1=a+b$ reads $2/\sqrt6=2/\sqrt6$. Existence therefore needs no appeal to Fubini–Study.

**The bracket, computed from scratch.** With $\varphi_{ab}=E_{ab}-E_{ba}$ and $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$, take $\omega_1=(\varphi_{12}+\varphi_{34})/\sqrt2$, $\omega_2=(\varphi_{13}+\varphi_{42})/\sqrt2$, $\omega_3=(\varphi_{14}+\varphi_{23})/\sqrt2$. The four terms give $-\varphi_{23}$, $-\varphi_{14}$, $-\varphi_{14}$, $-\varphi_{23}$, so

$$[\omega_1,\omega_2]=-(\varphi_{14}+\varphi_{23})=-\sqrt2\,\omega_3,\qquad \lVert[\omega_1,\omega_2]\rVert^2=2 .$$

Since $[\omega_i,\omega_j]=-\sqrt2\,\epsilon_{ijk}\omega_k$, **every** orthonormal pair in $\Lambda^+$ brackets to norm-squared $2$ (the cross product of an orthonormal pair is a unit vector). **The pair cap is saturated identically on this family**, the file's claim, confirmed.

**And the mass sits on the right index.** $[v_2,v_3]\perp v_2,v_3$ by antisymmetry of $c$, and lies in $\mathfrak{su}(2)_+=\mathrm{span}\{v_1,v_2,v_3\}$, so it is parallel to $v_1$. Hence $T_{1,N-1,N}=\lVert[v_2,v_3]\rVert^2=2$ **exactly**, and the single inequality of the proof is an equality here.

**Independent confirmation through criticality.** On $\mathfrak{su}(2)$ the only live structure constant is $T_{123}=2$, so $W^\#=\mathrm{diag}(2\lambda_2\lambda_3,\,2\lambda_1\lambda_3,\,2\lambda_1\lambda_2)$. At $(2,-1,-1)/\sqrt6$:

$$Q_{11}=\tfrac46+2\cdot\tfrac16=1=\theta\cdot\tfrac2{\sqrt6}\Rightarrow\theta=\tfrac{\sqrt6}2,\qquad Q_{22}=\tfrac16-\tfrac46=-\tfrac12=\theta\cdot\big(-\tfrac1{\sqrt6}\big)\ \checkmark$$

So $Q(W)=\theta W$ holds exactly and $\theta=\sqrt6/2=\sqrt{3/2}$, the same constant reached without touching $f(t)$.

**Finding 2 (no defect): the cap is attained, not approached.** Both routes give equality at a point that exists in $\mathrm{Weyl}_4$ and pads to every $n\ge4$. The brief's note is confirmed: $\mathfrak{su}(2)_+$ is a subalgebra, so $c_{\alpha\gamma\delta}\ne0$ with $\gamma,\delta\in\mathfrak{su}(2)_+$ forces $\alpha\in[\mathfrak{su}(2)_+,\mathfrak{su}(2)_+]=\mathfrak{su}(2)_+$; hence $W^\#$ (and $W^2$) stay inside $\Lambda^+$ and criticality survives padding at every $n$. **Sharp, not merely a cap.**

## Phase 5, the vanishing claim, derived

The sentence under attack: *"$c'$ is antisymmetric in three indices, so $S$ vanishes identically once $\dim\mathfrak m\le2$."*

- **The antisymmetry is in the indices claimed.** $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ in the orthonormal eigenbasis is totally antisymmetric ([conventions.md](../findings/conventions.md), from ad-invariance), and total antisymmetry is preserved under orthogonal change of basis. Confirmed by the block's own $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2$, which is Parseval for $c'$.
- **$\dim\le2$ is exactly what forces the vanishing, neither weaker nor stronger.** $S$ ranges all three indices over the negative eigenspace; with only two basis indices available every triple repeats one, and a totally antisymmetric tensor vanishes on a repeated index. At $\dim=3$ it is live, $\mathfrak m=\mathfrak{su}(2)$ gives $c'_{123}=\pm\sqrt2$ by the computation in Phase 4. So $2$ is the exact threshold.
- **The definition matches.** [graded-half.md:456](../findings/graded-half.md) fixes $S$ as the failure of $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, i.e. $\sum_{\alpha\beta\gamma\in\mathfrak m}c'^2$, the preamble's $\sum_{\lambda<0}c'^2$.
- **The consequence is valid.** R2's residual is conditioned on the slack being positive; $S\equiv0$ on the stratum means that hypothesis never fires, so the residual is vacuous there and an independent value bound is needed. That is exactly what L29 supplies.
- **Independent corroboration from another file.** [graded-half.md:458](../findings/graded-half.md) records $W_{\mathbb{CP}^2}$ as having $S=0$ with $[\mathfrak m,\mathfrak m]\to\mathfrak m$ at $10^{-32}$, measured rather than argued. Agrees.

**Finding 3 (no defect, one cross-reference owed): the derivation is correct, but the symbol $\mathfrak m$ is being reused.** In [ungraded-slack.md](../findings/ungraded-slack.md) and [graded-half.md](../findings/graded-half.md), $\mathfrak m=\mathfrak h^\perp$ for a **subalgebra** $\mathfrak h$; here it means the **negative eigenspace**. The two coincide on the subalgebra family (where $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ is positive on $\mathfrak h$ and negative on $\mathfrak m$) and diverge here, where $\ker W$ has dimension $N-3$ and belongs to neither. This is the same class as the $B$, $M$ and $\mu$ collisions already tabled in [conventions.md](../findings/conventions.md) and belongs in that table. Separately, $S=0$ on this stratum **is** trap W4's flagship instance ([INDEX-traps.md](../findings/INDEX-traps.md), "padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$"); the block should point at it, since a reader who knows only the block will read $S=0$ as evidence of gradedness, which W4 says it is not. Neither point touches the lemma.

## Phase 6, dimension-freeness: confirmed

Every ingredient is $n$-free: the eigen-expansion; $T\ge0$ totally symmetric; the pair cap $\lVert[X,Y]\rVert^2\le2$ (which follows from $\lVert[X,Y]\rVert_F\le\sqrt2\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ for normal $X$ together with $\lVert X\rVert_{\rm op}\le1$ at $\sum s_i^2=1$, no $n$ enters); trace-freeness; unit norm. Padding adds only zero eigenvalues, so it preserves *"exactly one positive and two negative"*, and it preserves $\theta$ ([conventions.md](../findings/conventions.md)). Attainment at $n=4$ therefore transports upward. At $n\le3$, $\dim\mathcal W_n=0$ and the hypothesis is empty. **"The bound carries no dimension restriction" is correct as written.**

## Phase 2 (revisited), the hypothesis wording: **L29 does not carry L33's defect**

L33 was one word from false because *"exactly one eigenvalue of one sign"* admits a distinct-values reading under which a $\mathrm{Weyl}_4$ witness refutes it. L29's phrasing is the same shape (*"exactly one positive and two negative eigenvalues"*) so the defect had to be checked, and it is **absent**, for a reason internal to the statement rather than by appeal to a file convention.

**Three independent disambiguators, each sufficient on its own.**

1. **The explicit list.** The statement continues *"$\lambda_1>0>-a\ge-b$"*, a list of three numbers offered as the eigenvalues. Under the distinct-values reading the list would be a list of *values*, and multiplicities would be unconstrained; but then "two negative eigenvalues" and "$-a\ge-b$" allow $a=b$, which is one distinct value, contradiction. So the list is with multiplicity.
2. **The equality clause.** Equality is *"attained at the spectrum $(2,-1,-1)/\sqrt6$"*, which has $a=b$, one distinct negative value. Under the distinct reading the attaining point **would not satisfy the lemma's own hypothesis**, making the statement self-contradictory. The multiplicity reading is the only one under which the statement is coherent.
3. **The proof uses multiplicity-one.** $(+++)$ and $(++-)$ are killed by *"only one exists"*, which is a statement about how many **indices** carry a positive eigenvalue, i.e. the multiplicity. Under the distinct reading with multiplicity $m\ge2$ on the positive side, $(++-)$ is combinatorially live at $m\ge2$ and $(+++)$ at $m\ge3$, and the proof as written collapses.

Point 2 is the strong one: it makes L29 **self-disambiguating everywhere it is quoted**, including [results.md:412](../results.md) and the summary at [results.md:144](../results.md), which both carry the attaining spectrum. This is exactly what L33 lacked, L33's disambiguation lives in a note in [stratum-two-negative.md](../findings/stratum-two-negative.md) that *"this file's own convention counts with multiplicity"*, and that convention does not travel with the quotation. L29 needs no travelling convention.

**Residual exposure, minor.** The *title* alone ("one positive and two negative eigenvalues cap $\theta$ at $\sqrt{3/2}$"), is ambiguous in isolation, and it is the title that appears at [plan.md:96](../plan.md), [INDEX-results.md](../findings/INDEX-results.md) and [plan-verification.md:38](../plan-verification.md). Nothing downstream is currently derived from the title alone, so this is a wording note, not a defect.

**Screen, reported as a screen.** Constructing $W^+=W^-=\mathrm{diag}(p,-a,a-p)$ in $\mathrm{Weyl}_4$ gives a tensor satisfying the *distinct-values* reading and failing the multiplicity one. Because $[\Lambda^+,\Lambda^-]=0$, $P$ and $\lVert W\rVert^2$ both split over the blocks, giving $\theta=\theta(W^+)/\sqrt2\le\sqrt3/2=0.866$. **It does not refute the distinct reading**, so whether L29 also happens to be true under that reading is left open, settling it would need a search over spectra with one distinct positive value at high multiplicity, which this footing forbids and which no result depends on.

## Phase 7, the citations: **three of eleven cite a strengthening the block itself disclaims**

The block's closing paragraph says, in its own words:

> *"It does not reach two or more positive eigenvalues alongside the two negative ones, where the $(+++)$ and $(++-)$ blocks reappear and the pair cap alone controls neither."*

| # | citation | what it uses | verdict |
| --- | --- | --- | --- |
| 1 | [plan.md:96](../plan.md) | the chain $[$L29–L36, L42$]$ caps the $\le2$-negative stratum | as stated |
| 2 | [plan-verification.md:38](../plan-verification.md) | checklist row | not a use |
| 3 | [results.md:144](../results.md) | cap, dimension-free, attained at $(2,-1,-1)/\sqrt6$ | as stated |
| 4 | [results.md:412](../results.md) | canonical statement, converse attributed to L72 | as stated, and **ahead of** findings/ |
| 5 | [results.md:767](../results.md) | L72 closes L29's converse clause | correct |
| 6 | [stratum-two-negative.md:11](../findings/stratum-two-negative.md) | pointer from the development section | as stated |
| 7 | [stratum-two-negative.md:272](../findings/stratum-two-negative.md) | ***"Lemma L29 already closes $k\le2$ outright"*** | **strengthening** |
| 8 | [stratum-two-negative.md:276](../findings/stratum-two-negative.md) | table row *"$k\le2$ positive eigenvalues \| Lemma L29, dimension-free"* | **strengthening** |
| 9 | [stratum-two-negative.md:421](../findings/stratum-two-negative.md) | table row *"$k\le2$ positive eigenvalues \| … **proved** (Lemma L29)"* | **strengthening** |
| 10 | [stratum-two-negative.md:438](../findings/stratum-two-negative.md) | L35's preamble: *"Lemma L29 covered only one positive eigenvalue"* | as stated |
| 11 | [isotropy-cap.md:290](../findings/isotropy-cap.md) | *"Lemma L29 covers rank 3 only"* | as stated |

**Finding 4 (DEFECT, in the record's prose): rows 7–9 contradict row 10, row 11 and the block's own closing sentence, and the two tables have a hole because of it.** The table at [line 421](../findings/stratum-two-negative.md) partitions the $\dim\mathfrak m\le2$ stratum into four regions, *"$k\le2$"*, and three regions all indexed *"$k\ge3$"*. If L29 covers only $k=1$, as its own closing paragraph and two other citations say, then **$k=2$ falls into no row of that assembly**. The same hole is in the table at line 276. The claim is rescued downstream by [Lemma L35](../findings/stratum-two-negative.md), which caps the stratum at any $k$ unconditionally, but that also means the four-region assembly is superseded rather than repaired.

## Phase 8, which side of the $k=2$ dispute is right, derived

The source of rows 7–9 is the development paragraph above the block: *"The Lemma extends to two positive eigenvalues, for the same reason. $(+++)$ needs three distinct positive indices, so it vanishes at $k=2$ as well … So the Lemma covers $k\le2$, i.e. rank $\le4$."*

**Finding 5 (DEFECT, in the block): the closing sentence is wrong at $k=2$, on both of its two counts.** Splitting by sign and reading off the sign of each block's summand:

| block | sign of $\lambda_\alpha\lambda_\beta\lambda_\gamma$ | status at $k=2$ |
| --- | --- | --- |
| $(+++)$ | $>0$, must be bounded | needs **three distinct** positive indices; only two exist, and $T$ vanishes on repeats. **Vanishes.** |
| $(++-)$ | $<0$ against $T\ge0$ | combinatorially live, but **contributes negatively**, so dropping it is a valid upper bound at no cost |
| $(+--)$ | $>0$, must be bounded | $\tfrac12\cdot6\,ab\sum_{i\le k}T_{i,N-1,N}\lambda_i\le3ab\,\lambda_1\sum_iT_{i,N-1,N}\le6\lambda_1ab$, **the same pair cap, unchanged** |
| $(---)$ | $<0$ | zero by antisymmetry at $\dim\mathfrak m=2$; and in any case droppable upward |

So at $k=2$: $(+++)$ **does not** "reappear", and $(++-)$ reappearing is harmless. The block's stated reason for its own limitation is incorrect. The chain at $k=2$ is

$$P\le\lambda_1^3+\lambda_2^3-a^3-b^3+6\lambda_1ab,\qquad \lambda_1+\lambda_2=a+b,\ \ \textstyle\sum\lambda^2=1 .$$

**Screen, reported as a screen.** A $400\times400$ grid over the two scale-free ratios returns $\max=1.2247448713915894$ against $\sqrt{3/2}=1.224744871391589$, at $\lambda_2=0$, $a=b$, i.e. the development paragraph's *"attained only in the limit $\lambda_2\to0$, $a=b$"*. **This is a screen and not evidence for the positive claim**; what it screens is that the $k=2$ extension is not obviously false. By hand I get the matching structural fact that the boundary $\lambda_2=0$ is a *degenerate* stationary point: on the symmetric slice, $\mathrm dP/\mathrm d\lambda_2$ along the norm constraint is $-\tfrac92\sigma^2+\tfrac{27}4\sigma^2\cdot\tfrac23=0$ exactly. So the $k=2$ claim is a boundary maximum with vanishing first variation, which is why it needs an argument rather than an inspection, and the development paragraph supplies none ("maximising the resulting bound" is asserted, and the bound is not written down).

**A correction to an existing review.** [ELIM-stratum.md:156](ELIM-stratum.md) faults the development paragraph because *"the $(++-)$ block … is live here and the paragraph is silent on it"*. Live it is, but silence is correct: a block that enters an upper estimate with a negative sign needs no bound. The paragraph's real gap is the unwritten maximisation, not the $(++-)$ block.

## Phase 9, the equality clause is **stale**

The block still reads: *"The converse … is reduced to 'no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ for even $r\ge6$', excluded numerically at $r=6,8,10$ and untested at $r\ge12$."*

**Finding 6 (DEFECT, staleness): [Lemma L72](../findings/stratum-two-negative.md), 432 lines below in the same file, closes that clause outright and says so.** I verified L72 by hand rather than taking it. With spectrum $(\lambda_1,-a,-b,0,\dots)$ the only live bracket entry is $T=T_{1,N-1,N}$, so $W^\#=\mathrm{diag}(Tab,\,-T\lambda_1b,\,-T\lambda_1a,\,0,\dots)$ and $Q=\theta W$ gives the three rows printed. Setting $a=b$: row (i) is $Ta=2(\theta-2a)$ and row (ii) is $2Ta=\theta+a$, so $4\theta-8a=\theta+a$, $\theta=3a$, $T=2$, and $6a^2=1$ gives $\theta=3/\sqrt6=\sqrt{3/2}$. Correct, and it needs no numerics and no $r$-by-$r$ exclusion.

[results.md:412](../results.md) has already been updated to *"The converse … is Lemma L72"*. **The canonical block in [findings/](../findings/) is behind the pointer file that points at it**, the reverse of the intended direction, and the sentence a reader reaches by following results.md's "Proof:" link is the outdated one.

## Phase 10, the provenance line is **FALSE**, for the third time this session

The block opens: *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy."*

Checked against git. The move is commit `a9e4b8c0` ("refactor(results): the proofs move to findings, results.md states and points", 2026-08-31 19:34:41 +0200).

| probe | result |
| --- | --- |
| `git grep -ln '<canonical-proof phrase>' a9e4b8c0^` | `results.md` only |
| `git grep -ln 'f\$ has a unique stationary point' a9e4b8c0^` | **`findings/stratum-two-negative.md`** |
| `git grep -c 'frac{9\sqrt2' a9e4b8c0^ -- '*.md'` | **three files**: `results.md`, `findings/stratum-two-negative.md`, `findings/isotropy-cap.md` |

**Finding 7 (DEFECT, provenance):** immediately before the move, **this same file** already carried the complete argument, statement, the three-block split, the pair cap, $f(t)$, the unique stationary point at $t=1$, and $f(1)=\sqrt{3/2}$, in the section *"The one-positive case, in development form"* that still sits directly above the L29 heading at [lines 9–34](../findings/stratum-two-negative.md). results.md was not "the only copy"; it was one of three files carrying $f(t)$. The probe that appears to confirm the line (searching for the *canonical* proof's wording), only shows that the canonical *phrasing* was unique, which is not what the sentence claims.

This is the same false sentence that [Lemma L33](../findings/stratum-two-negative.md) already has struck out fourteen lines below, with the same wording and the same date. The correction was applied to L33 and not to its neighbour. The second half of the line (*"That file now carries the statement and points here"*), is true: [results.md:412](../results.md) is statement plus pointer.

## Phase 11, the rest of the file, and the rest of findings/

- **[Lemma L34](../findings/stratum-two-negative.md) does not touch L29.** Its full-support witnesses have spectra $(-3,-1,1,1,1,1)/\sqrt{14}$ at $m=6$ and $\{-1/\sqrt3\,(\times2),\,1/(2\sqrt3)\,(\times4)\}$ at $m=8$, **four** positive eigenvalues each, outside L29's hypothesis. L34's own paragraph says so: *"With one positive eigenvalue, Ricci-flatness forces $U=\mathrm{im}\,v_1$."* What L34 refutes is the *descent* that the general-$k$ argument used, which L29's proof never invokes.
- **[Lemma L35](../findings/stratum-two-negative.md) supersedes L29 rather than contradicting it**, same cap, at any number of positive eigenvalues.
- **The closing section at [line 608](../findings/stratum-two-negative.md) agrees numerically.** Its $\theta_0$ row reproduces from $\theta_0(n)^2=2(n-1)(n-2)/n^2$ at $n=6,8,10,12$, and its crossover $6+2\sqrt7\approx11.29$ is the root of $2(n-1)(n-2)/n^2=3/2$, i.e. $n^2-12n+8=0$. Both confirm the un-deflated reading of the constant a third time.
- **No file in [findings/](../findings/) restates the cap differently.** Grepping for the constant beside "two negative" outside the target file returns nothing.

## VERDICT: CONFIRMED

**The statement is true and the proof is sound.** Every step reproduces from the definitions: the $\tfrac12\sum T\lambda\lambda\lambda$ expansion (certified against $\operatorname{tr}W^\#=-1$), the three structural vanishings, the $(+--)$ count of $3T_{1,N-1,N}\lambda_1ab$, $\lambda_1=a+b$ from the trace of Ricci-flatness, $f(t)=9\sqrt2\,t(t+1)/(4(t^2+t+1)^{3/2})$, its unique stationary point at $t=1$, and $f(1)=\sqrt6/2$. The constant is the un-deflated $\sqrt{3/2}=1.224745$, confirmed three independent ways. The cap is **attained**, not approached, verified both through the saturated pair cap $\lVert[\omega_1,\omega_2]\rVert^2=2$ and, separately, by checking $Q(W)=\theta W$ at $(2,-1,-1)/\sqrt6$ directly. The bound is genuinely dimension-free and survives padding.

**It does not carry L33's ambiguity defect**: the equality clause names a spectrum with $a=b$, so the distinct-values reading makes the statement contradict itself, and the multiplicity reading is forced wherever the statement is quoted, no travelling convention required.

**Four defects, none in the statement or its proof.**

| # | defect | where | severity |
| --- | --- | --- | --- |
| 5 | The closing sentence's reason for the lemma's own scope is wrong at $k=2$: $(+++)$ does **not** reappear (it needs three distinct positive indices), and $(++-)$ reappearing costs nothing because it enters with a negative sign against $T\ge0$ | the block's last paragraph | **material**, it is the sentence three citations contradict |
| 4 | Three citations credit L29 with $k\le2$; two others and the block itself say $k=1$. The two assembly tables partition the stratum as "$k\le2$" plus three "$k\ge3$" rows, so under the block's own scope **$k=2$ falls into no row** | [lines 272, 276, 421](../findings/stratum-two-negative.md) against [line 438](../findings/stratum-two-negative.md) and [isotropy-cap.md:290](../findings/isotropy-cap.md) | **material**, though rescued downstream by L35 |
| 6 | The equality clause is stale: it still hedges on solves at $r=6,8,10$ with $r\ge12$ untested, while [Lemma L72](../findings/stratum-two-negative.md) closes it outright 432 lines below in the same file, and [results.md:412](../results.md) has already been updated while the block it points at has not | the block's Statement | **material**, the stale sentence is what a reader following the "Proof:" pointer arrives at |
| 7 | *"where the argument was the only copy"* is **false**: at `a9e4b8c0^` this same file already held the complete argument in development form, and $f(t)$ sat in three files | the block's provenance line | metadata, but it is the third such false line found this session and the identical correction is already struck out fourteen lines below in L33 |

**Recommended repairs, in order.**

1. Replace the closing sentence with what is actually true: *"It reaches $k=1$; at $k=2$ the $(+++)$ block still vanishes and $(++-)$ enters negatively, so the same chain applies, and from $k=3$ the $(+++)$ block is live and the pair cap alone does not control it."* Then decide $k\le2$ or $k=1$ **once**, and make lines 272, 276, 421, 438 and [isotropy-cap.md:290](../findings/isotropy-cap.md) agree with it. If $k\le2$ is kept, the development paragraph owes the written-out maximisation, the boundary $\lambda_2=0$ is a *degenerate* stationary point, so it is not settleable by inspection.
2. Replace the equality clause with a pointer to Lemma L72, matching [results.md:412](../results.md).
3. Strike the provenance line the way L33's was struck, naming the development-form section as the pre-existing copy.
4. Add $\mathfrak m$ to [conventions.md](../findings/conventions.md)'s table of colliding symbols, and point the preamble's $S=0$ at trap W4.

**One correction owed to an existing review.** [ELIM-stratum.md:156](ELIM-stratum.md) faults the $k=2$ paragraph for being silent on the $(++-)$ block. Silence is correct there, the block has the wrong sign to threaten an upper bound. The paragraph's real gap is the unwritten maximisation.

**Nothing was computed beyond two screens**, both reported as screens and neither used as evidence for a positive claim: the $k=2$ chain maximum, and the distinct-values candidate witness. Every positive statement above is derived by hand.
