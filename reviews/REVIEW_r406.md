# Review r406, Gate 2 on I7's spectral-gap opening and the trace relation

*Adversarial review, cold derivation first. Target: the last two sections of [ATTEMPTS.md](../ATTEMPTS.md), "I7 opened: the spectral gap generalises off the diagonal locus, and it is exactly a $\#$-positivity question" and "What the generalised gap would buy, computed before assuming it". **Analysis only**; no computation was run, and nothing below needed one, every witness is a value the record already catalogues or a six-eigenvalue hand computation.*

## Verdicts

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | $\theta\mathop{\mathrm{tr}}W=1$, i.e. $\mathop{\mathrm{tr}}W=1/\theta$, at every critical point | **REFUTED**, $\mathop{\mathrm{tr}}W=0$ at every Weyl tensor; witness padded $W_{\mathbb{CP}^2}$, from the record's own [INDEX-values.md](../findings/INDEX-values.md) |
| 2 | $\sum_\alpha\lambda_\alpha^2=2\lVert W\rVert^2=2$ | **REFUTED**, $\sum_\alpha\lambda_\alpha^2=\lVert W\rVert^2=1$. The $2$ is the **vertex matrix**'s Frobenius mass, imported by a letter collision |
| 3 | $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$, and the boxed sign equivalence | **CONFIRMED but NOT NEW**, it is relation (C) and the boxed $W^\#=\theta W-W^2$ paragraph of [bounds.md](../findings/bounds.md), where it is stated in the strictly stronger eigenvector form |
| 4 | Conditional: $\mathop{\mathrm{spec}}(W)\cap(0,\theta)=\varnothing$ off the diagonal locus | **REFUTED as a hypothesis**, false at *every* critical point in the band, unconditionally, in two lines. Witness padded $W_{\mathbb{CP}^2}$ |
| 5 | Conditional structure $p=1$, $W=\lambda_1vv^\top-K$ with $K\succeq0$ | **VACUOUS**, the antecedent is false; and with the corrected norm the same count gives $p=0$, contradicting $\mathop{\mathrm{tr}}W=0$ |
| 6 | $\theta\le\sqrt2$ is all the gap yields; $\theta\ge1/\sqrt2$ free | **REFUTED / VACUOUS**, $\lambda_1\le\sqrt2$ is $\lambda_1\le\lVert\lambda\rVert$ mis-normalised; corrected it is $\lambda_1\le1$. $\theta\ge1/\sqrt2$ rests on claim 1 and falls with it |
| 7 | "Off the diagonal locus the same rearrangement holds verbatim" | **REFUTED**, [Lemma L129](../findings/diagonal-half.md)'s identity comes from the diagonal *entries* of criticality on $\Lambda^2$, not from the operator rearrangement, and the proposed statement does not restrict to L129 on the diagonal locus |

**One sentence: the section identifies $\mathop{\mathrm{spec}}_{\Lambda^2}(W)$ with $\mathop{\mathrm{spec}}(K)$ for the vertex matrix $K$, and those are different objects, on the diagonal locus $\mathop{\mathrm{spec}}_{\Lambda^2}(W)$ is the multiset of *entries* of $K$. Every claim in both sections traces to that identification or to the factor $2$ that came with it.**

---

## The cold derivation, before the sections were opened

**Rearranging criticality.** $Q(W)=\theta W$ is $W^\#=\theta W-W^2$ as operators, so for a unit eigenvector $v$ of $W$ at $\lambda$, $W^\#v=\lambda(\theta-\lambda)v$ and a fortiori $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$. Summing over an orthonormal eigenbasis, $\mathop{\mathrm{tr}}W^\#=\theta\mathop{\mathrm{tr}}W-\mathop{\mathrm{tr}}W^2$.

**The trace of a Weyl tensor on $\Lambda^2$ is zero.** $\mathop{\mathrm{tr}}_{\Lambda^2}W=\tfrac12\sum_{i,j}W_{ijij}=\tfrac12\mathop{\mathrm{scal}}(W)$, and $W$ is totally trace-free, so $\mathop{\mathrm{scal}}(W)=0$ and $\mathop{\mathrm{tr}}W=0$. This needs no criticality and no normalisation.

**$\mathop{\mathrm{tr}}W^\#=-\mathop{\mathrm{tr}}W^2$, likewise unconditionally.** Two independent routes agree. (i) The Ricci-flow trace: with $\partial_tR=\Delta R+2(R^2+R^\#)$ and $\partial_t\mathop{\mathrm{scal}}=\Delta\mathop{\mathrm{scal}}+2\lvert\mathrm{Ric}\rvert^2$ and $\mathop{\mathrm{tr}}_{\Lambda^2}R=\mathop{\mathrm{scal}}/2$, one gets $\mathop{\mathrm{tr}}R^2+\mathop{\mathrm{tr}}R^\#=\tfrac12\lvert\mathrm{Ric}\rvert^2$ (checked against $R=\mathrm{Id}$, where $N+(n-2)N=n(n-1)^2/2$) and $\mathrm{Ric}(W)=0$ kills the right side. (ii) The record's own reason, [bounds-relaxations.md](../findings/bounds-relaxations.md): $Q$ preserves the trace-free Weyl space, so $\mathop{\mathrm{tr}}Q(W)=0$.

**Therefore the trace of the criticality equation is empty.** $\mathop{\mathrm{tr}}W^2+\mathop{\mathrm{tr}}W^\#=0$ *is* $\mathop{\mathrm{tr}}Q(W)=0$, and criticality turns that into $\theta\mathop{\mathrm{tr}}W=0$, which $\mathop{\mathrm{tr}}W=0$ already says. **Contracting criticality against the identity cannot produce information, because $\mathop{\mathrm{tr}}W^\#=-1$ is that contraction already.** Any relation extracted this way is circular by construction; the only way to get a nonzero right-hand side is a normalisation mismatch between $\mathop{\mathrm{tr}}W^\#$ and $\sum\lambda_\alpha^2$.

## The two named points, computed independently and checked against the record

Both were computed by hand from the definitions, in $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, where $\#$ is block-diagonal for any Weyl tensor (the mixed block of $W^\#$ needs the mixed block of $W$, which vanishes) and $(A^\#)_{ii}=2a_ja_k$ on each $\mathfrak{su}(2)$ factor, normalisation fixed by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$.

| | $S^2\times S^2$ | padded $W_{\mathbb{CP}^2}$ |
| --- | --- | --- |
| $\Lambda^2$ spectrum, unnormalised | $\tfrac23,\tfrac23,-\tfrac13^{(4)}$ | $(2,-1,-1,0,0,0)/\sqrt6$ |
| $\mathop{\mathrm{tr}}W$ | $0$ exactly | $0$ exactly |
| criticality residual | $0$ ($W^2+W^\#=1\cdot W$ | $0$), $a_i^2+2a_ja_k=\theta a_i$ |
| $\mathop{\mathrm{tr}}W^2$ | $4/3$ | $1$ |
| $\mathop{\mathrm{tr}}W^\#$ | $-4/3$ | $-1$ |
| $\theta$ at $\mathop{\mathrm{tr}}W^2=1$ | $\sqrt3/2=0.866025$ | $\sqrt{3/2}=1.224745$ |

Both $\theta$'s land on catalogued values: $\sqrt3/2=\theta_0(4)$ from $\theta_0(n)^2=2(n-1)(n-2)/n^2$ in [problem.md](../findings/problem.md), and $\sqrt{3/2}$ is the band edge and the $W_{\mathbb{CP}^2}$ row of [INDEX-values.md](../findings/INDEX-values.md). **They land there only under $\lVert W\rVert^2=\mathop{\mathrm{tr}}_{\Lambda^2}(W^2)$; putting the $\tfrac12$ at the operator level would return $\sqrt{3/2}$ and $\sqrt3$, exactly the $\sqrt2$ inflation [conventions.md](../findings/conventions.md) warns about.** So the normalisation is settled from three independent directions, and $\mathop{\mathrm{tr}}W^\#=-1$ is **correct** in it.

**And $\mathop{\mathrm{tr}}W^\#=-\mathop{\mathrm{tr}}W^2$ is confirmed at both points**, which is what makes the trace route vacuous rather than merely unproductive.

## Claim 2, $\sum_\alpha\lambda_\alpha^2=2$ is the vertex matrix's number, not $W$'s

[INDEX-values.md](../findings/INDEX-values.md) states the witness outright: padded $W_{\mathbb{CP}^2}$ has *"$\Lambda^2$ spectrum $(2,-1,-1,0^7)/\sqrt6$, $\lVert W_0\rVert^2=1$"*. Then $\sum_\alpha\lambda_\alpha^2=6/6=1=\lVert W\rVert^2$. **The record refutes $\sum\lambda_\alpha^2=2\lVert W\rVert^2$ on its own catalogued extremiser.**

**Where the $2$ comes from, exactly.** The vertex matrix $K$ is hollow with $\lVert K\rVert_F^2=\sum_{i\ne j}K_{ij}^2=2\sum_{i<j}K_{ij}^2=2\lVert W\rVert^2=2$, and [diagonal-half.md](../findings/diagonal-half.md) states $\lVert K\rVert_F^2=2$ in as many words when it builds its $n=8$ witness. So $\sum(\text{eigenvalues of }K)^2=2$ is right and $\sum(\text{eigenvalues of }W\text{ on }\Lambda^2)^2=1$ is right, and the section used the first figure for the second spectrum.

**The mechanism is a live letter collision, and it is not in [conventions.md](../findings/conventions.md).** [diagonal-half.md](../findings/diagonal-half.md) writes $M$ (and $K$) for the $n\times n$ **vertex matrix**; [bispectral.md](../findings/bispectral.md) writes $M$ for **$W$ acting on $\Lambda^2$**, and [conventions.md](../findings/conventions.md)'s "two spectra" row is the second one ($\mu=\mathop{\mathrm{spec}}(M)$ on $\Lambda^2$ at $\lVert M\rVert_F=1$, $\sum\mu^2=1$). conventions.md flags that the letter $B$ means two things; **$M$ is a second collision, it carries a factor $2$ across it, and both sections under review were written through it.** Recommend a conventions.md row.

## Claim 1, $\theta\mathop{\mathrm{tr}}W=1$: REFUTED

With $\sum\lambda_\alpha^2=1$, $\mathop{\mathrm{tr}}W^\#=-1$ gives $\theta\mathop{\mathrm{tr}}W-1=-1$, i.e. $\theta\mathop{\mathrm{tr}}W=0$, i.e. $\mathop{\mathrm{tr}}W=0$, the statement already on the record at [bounds.md](../findings/bounds.md) (*"$\lambda_{\min}<0\le\lambda_{\max}$, which on $\mathcal W_n$ is supplied by $\mathop{\mathrm{tr}}W=0$"*) and at [bounds-relaxations.md](../findings/bounds-relaxations.md) (*"$\mathop{\mathrm{tr}}W=0$ forces $\lambda_{\min}<0$"*, and the per-row relations described as *"a restatement of trace-freeness"*).

**Witnesses.** Padded $W_{\mathbb{CP}^2}$: $\mathop{\mathrm{tr}}W=(2-1-1)/\sqrt6=0$ and $\theta=\sqrt{3/2}$, so $\theta\mathop{\mathrm{tr}}W=0\ne1$. $S^2\times S^2$: $\mathop{\mathrm{tr}}W=2\cdot\tfrac23-4\cdot\tfrac13=0$ and $\theta=\sqrt3/2$. Every sphere product likewise, $\mathop{\mathrm{tr}}W=0$ is an identity there, verified in closed form: $m(m-1)(1-\mu)-m^2\mu=0$ at $\mu=(m-1)/(2m-1)$.

**The consequence drawn is also wrong and the correct one is stronger.** The section infers *"$\mathop{\mathrm{tr}}W>0$, so $W$ has a positive eigenvalue"*. The truth $\mathop{\mathrm{tr}}W=0$ with $W\ne0$ gives $\lambda_{\min}<0<\lambda_{\max}$ (both signs, not one) and that too is already on the record.

## Claim 4, the conditional hypothesis is false, unconditionally, in the band

This is the finding that closes the route, and it takes two lines.

$$\lambda_{\max}^2\le\sum_\alpha\lambda_\alpha^2=\lVert W\rVert^2=1\quad\Longrightarrow\quad\lambda_{\max}\le1,\qquad\text{while}\qquad\theta\ge\sqrt{3/2}=1.2247>1 ,$$

and $\mathop{\mathrm{tr}}W=0$ with $W\ne0$ gives $\lambda_{\max}>0$. Hence

$$\boxed{\ \lambda_{\max}\in(0,\theta)\ \text{ at EVERY critical point in the band.}\ }$$

**So $\mathop{\mathrm{spec}}(W)\cap(0,\theta)=\varnothing$ is false at every band critical point, diagonal or not, and no proof of it exists to be found.**

**A witness on the record, off the diagonal locus, at the band edge.** Padded $W_{\mathbb{CP}^2}$ has $\lambda_{\max}=2/\sqrt6=0.816497$ and $\theta=\sqrt{3/2}=1.224745$, so $\lambda_{\max}\in(0,\theta)$. It is genuinely off the diagonal locus: a coordinate-diagonal $W$ has $\mathop{\mathrm{spec}}_{\Lambda^2}(W)=\{K_{ij}\}_{i<j}$, so three nonzero eigenvalues would mean three nonzero entries; every vertex met by a nonzero entry needs its incident entries to sum to zero, hence degree $\ge2$, hence with six endpoint-slots exactly three vertices of degree two, a triangle with $a+b=b+c=c+a=0$, forcing $a=b=c=0$. Contradiction.

**A second witness, on the diagonal locus, well inside the band.** $S^6\times S^6$ at $n=12$, $\theta=\theta_0(12)=1.236033$, has $\Lambda^2$ eigenvalues $\pm$ of size $1/\sqrt{(2m-1)(m-1)}=1/\sqrt{55}=0.1348$ and $-0.1348\cdot\tfrac{m-1}{m}$, two orders of magnitude below $\theta$. **$\theta$ is not comparable to $\lambda_{\max}$ at all: at a critical point it is dominated by the $\#$ term, and the whole spectral-count framing presumes a comparison that the record's own maximiser refutes.**

**And the section's own identity says the route's target sign is unavailable.** The route wants $\langle v,W^\#v\rangle\le0$ on eigenvectors, to force the gap. But $\langle v_{\max},W^\#v_{\max}\rangle=\lambda_{\max}(\theta-\lambda_{\max})>0$ at every band critical point, by the display above. **The $\#$-positivity question the section opens has a forced answer, and it is the one that closes the route.** Recommend recording as a fence post.

## Claim 7, the rearrangement does not transport, and does not restrict correctly

Two separate failures, either one fatal.

- **It is not L129's mechanism.** [Lemma L129](../findings/diagonal-half.md) rests on $K^2-\theta K=L(w)$, $w=K^{\circ2}$, and that identity is assembled from the **diagonal entries of criticality on $\Lambda^2$**, $(W^2)_{(ab),(ab)}=K_{ab}^2$ and $(W^\#)_{(ab),(ab)}=(K^2)_{ab}$, as [diagonal-half.md](../findings/diagonal-half.md) states, together with hollowness of $K$. The nonnegativity that does the work is nonnegativity of the *Hadamard square* $K_{ab}^2$, an entrywise fact with no operator counterpart. The operator rearrangement $W^2-\theta W=-W^\#$ is criticality rewritten and carries nothing.
- **It does not restrict to L129.** On the diagonal locus $\mathop{\mathrm{spec}}_{\Lambda^2}(W)$ is the multiset of *entries* $\{K_{ab}\}$, while L129 constrains the *eigenvalues* of $K$. At $S^2\times S^2$ those are $\{0.5774^{(2)},-0.2887^{(4)}\}$ and $\{1.1547,-0.5774^{(2)},0\}$, different multisets, different scales, and L129 holds for the second while failing for the first. **A proposed generalisation that is false on the locus whose special case it claims to extend is not a generalisation.**

## Claims 5 and 6, what the conditional would have bought

Vacuous, since the antecedent is false; recorded because the arithmetic is wrong independently of that.

- **$p=1$.** With the correct $\sum\lambda_\alpha^2=1$, the same count reads $p\theta^2\le1$ with $\theta^2\ge3/2$, giving $p\le2/3$, i.e. $p=0$, which contradicts $\lambda_{\max}>0$ together with the gap. **So the hypothesis is not merely unproven; assuming it in the band yields a contradiction in one line, which would settle the conjecture off the diagonal locus outright.** A hypothesis that cheap is a hypothesis to test before chasing, and it fails.
- **Rank one minus PSD.** Logically sound *given* $p=1$: $Kv=0$ and $K=-W\succeq0$ on $v^\perp$, so $K\succeq0$. "All others $\le0$" is right under the stated open-interval hypothesis. Note the section weakened L129's half-open $(0,\theta]$ to the open $(0,\theta)$ without saying so; harmless here, but it drops the endpoint that [diagonal-half.md](../findings/diagonal-half.md) records as the half that matters.
- **$\theta\le\sqrt2$.** This is $\theta\le\lambda_1\le\sqrt{\sum\lambda_\alpha^2}$, Cauchy–Schwarz and nothing else. Corrected it is $\theta\le\lambda_1\le1$. **The $\sqrt2$ that appears is a coincidence with a number the record already carries**, $\sqrt2=\lim_n\theta_0(n)$, the first row of [INDEX-values.md](../findings/INDEX-values.md), which is why the wrong figure read as meaningful. *Nothing sits **at** $\sqrt2$: $\theta_0(n)<\sqrt2$ strictly for every $n$, approached from below.*
- **$\theta\ge1/\sqrt2$ "free".** Derived from $\lambda_1\ge1/\theta$, hence from claim 1; it falls with it. It was also never free, it used $p=1$, which used the band.

*A remark the section gets backwards in emphasis: had $\theta\le\sqrt2$ been true unconditionally it would be the record's best bound by a wide margin, the LP relaxations of [bounds-relaxations.md](../findings/bounds-relaxations.md) return $1.6038$ at $n=6$ and $2.2913$ at $n=8$, and asymptotically sharp, since $\sup_n\theta_0(n)=\sqrt2$. Dismissing $\sqrt2$ as "not $\sqrt{3/2}$" mistakes the target: the conjecture's bound is $\theta_0(n)$, and $\sqrt{3/2}$ is where $\theta_0(n)$ crosses $W_{\mathbb{CP}^2}$, which is where $n\ge12$ comes from.*

## Claim 3, novelty

**Zero, and the recorded form is stronger.** [bounds.md](../findings/bounds.md) carries, in a boxed paragraph: *"At a critical point $Q(W)=\theta W$ means $W^\#=\theta W-W^2$: $W^\#$ is a polynomial in $W$ ... So $W$ and $W^\#$ share eigenspaces, $W^\#$ acts on $E_a$ by the scalar $\theta\lambda_a-\lambda_a^2$"*, the eigenvector statement, of which $\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$ is the quadratic-form shadow. The same file lists it again as per-index relation **(C)**, $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$, which is the identity contracted through $Q_k=2(W^\#)_{kk}$, and describes the three relations as *"the whole of what the Killing form, Ricci-flatness and criticality give"*. The same file also records the consequence the section needed and did not draw: *"every scalar built from $W^\#$ at one eigenvector is a function of $(\lambda,\theta)$. That is what made [R14](../routes.md) circular."*

**So the section re-derives a recorded identity, and the recorded warning attached to that identity is precisely the failure mode the section then walks into.** The boxed sign equivalence adds only the observation that $\lambda(\theta-\lambda)>0\iff\lambda\in(0,\theta)$ for $\theta>0$.

## Silently used hypotheses

1. **$\mathop{\mathrm{spec}}_{\Lambda^2}(W)=\mathop{\mathrm{spec}}(K)$**, the load-bearing one, and false. Everything else follows from it.
2. **$\theta>0$**, needed for the boxed equivalence and for $p\theta^2\le\sum\lambda_\alpha^2$. True in the band, unstated.
3. **The eigenbasis is orthonormal**, used in "summed over an eigenbasis". True ($W$ symmetric), unstated.
4. **The band**, carried into "$p\le4/3$" and thence into $p=1$, into $\lambda_1\ge1/\theta$, and into "$\theta\ge1/\sqrt2$ comes free", which is therefore not free.
5. **L129's interval silently opened** from $(0,\theta]$ to $(0,\theta)$.
6. **$\lambda_1\ge1/\theta$ needs $\sum_{\alpha\ge2}\lambda_\alpha\le0$**, hence $p=1$, hence the band, stated as if it followed from the trace relation alone.

## What survives, and what to record

- **Nothing of the two sections' claims survives as stated.** The identity in claim 3 survives as a re-derivation of recorded material.
- **One new fence post is worth writing**, from the section's own identity: *at every critical point in the band, $\lambda_{\max}\le\lVert W\rVert=1<\sqrt{3/2}\le\theta$ while $\mathop{\mathrm{tr}}W=0$ forces $\lambda_{\max}>0$, so $\lambda_{\max}\in(0,\theta)$ and $\langle v_{\max},W^\#v_{\max}\rangle>0$. Any route seeking a $\Lambda^2$ spectral gap at $\theta$, or a nonpositive $\#$-form on $W$'s positive eigenvectors, is closed before it starts.*
- **One conventions.md row is owed**: the letter $M$ denotes the $n\times n$ vertex matrix in [diagonal-half.md](../findings/diagonal-half.md) and $W$ on $\Lambda^2$ in [bispectral.md](../findings/bispectral.md), and $\lVert\cdot\rVert_F^2$ differs by exactly the factor $2$ that produced both sections' errors.
- **A standing check the record already implies**: $\mathop{\mathrm{tr}}W^\#=-1$ is equivalent to $\mathop{\mathrm{tr}}Q(W)=0$, so the trace of the criticality equation is spent. No route may extract a relation from it.
