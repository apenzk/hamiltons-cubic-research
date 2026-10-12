# Review r321, the walk identity, the block truncation, and whether R13's count closes

Adversarial Gate 2 audit of the three claims U1–U3 recorded in [findings/bounds.md](../findings/bounds.md) under "The walk identity at the $\lambda_{\min}$ eigenvector", the first step of route [R13](../routes.md).

**Everything below is computed from a from-scratch implementation** in [scripts/reviewers/r321/core.py](../scripts/reviewers/r321/core.py): $\mathfrak{so}(n)$ basis $E_{ij}$ orthonormal for $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$, structure constants by direct matrix commutators, $\mathrm{Weyl}_n$ as the nullspace of (first Bianchi $\oplus$ Ricci) on symmetric operators, and $\mathrm{sharp}(n,W)_{ab}=-\tfrac12\operatorname{tr}(A_aWA_bW)$. Nothing is imported from the repository's scripts. Self-validation: $\dim\mathrm{Weyl}_n=35,84,168,300$ at $n=5,6,7,8$, matching $n(n+1)(n+2)(n-3)/12$; $S^{n/2}\times S^{n/2}$ comes out critical with $\theta=\theta_0(n)$ to $10^{-15}$; and $\dim\mathfrak m$, $\dim\mathfrak p$, $\dim\ker$, $\theta$ and $S_{\mathfrak{mpp}}$ agree with the record's own table at all ten catalogued points.

| claim | verdict |
|---|---|
| U1 walk identity, mass $2(n-2)$, critical-point value, sign of sharp | **CONFIRMED**, and all three are derivable, not just measurable |
| U2 "$\mathfrak m\times\mathfrak m$ vanishes **iff** $S_{\mathfrak{mmm}}=0$", "$\mathfrak p\times\mathfrak p$ vanishes **iff** $S_{\mathfrak{mpp}}=0$" | **REFUTED** in the "only if" direction of both, at genuine critical points; "if" confirmed |
| U2 "the $\mathfrak m$–$\mathfrak p$ sum is strictly negative" | **CONFIRMED**, with a proof |
| U2 "the $\mathfrak p$–$\mathfrak p$ sum is strictly positive" | **REFUTED**, it is $0$ at every sphere product, $\mathbb{CP}^3$, $\mathbb{CP}^4$ and the $n=8$ witness |
| U2 reported $1.00$ and $0.347$ at the $C_5$ blow-up and its $\mathrm{SO}(10)$-conjugate | **REFUTED**, the block is a conjugation invariant, so two conjugate points cannot differ; both give $1/90$ |
| U3 can the count be completed in this form | **NO**, and fence post F10 is **not** the operative obstruction |

---

## U1, the walk identity. CONFIRMED, and it is a theorem rather than a measurement

All three parts follow from the definitions in three lines each; the numerics are a check on the implementation, not the evidence.

**The identity.** With $W\varphi_a=\lambda_a\varphi_a$ orthonormal, $v=\varphi_1$, $c_{1ab}=\langle[v,\varphi_a],\varphi_b\rangle$, expand the trace in the eigenbasis: $\mathrm{ad}(v)\varphi_a=\sum_bc_{1ab}\varphi_b$, so $\langle\varphi_a,\mathrm{ad}(v)W\mathrm{ad}(v)W\varphi_a\rangle=\lambda_a\sum_b\lambda_bc_{1ab}c_{1ba}=-\lambda_a\sum_b\lambda_bc_{1ab}^2$ by antisymmetry of $\mathrm{ad}(v)$. Hence $\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)=-\sum_{a,b}\lambda_a\lambda_bc_{1ab}^2$ and $\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_bc_{1ab}^2$.

**The mass is exact and universal, and stronger than recorded.** $\sum_{a,b}c_{1ab}^2=-\operatorname{tr}(\mathrm{ad}(v)^2)$, which is the Killing form $B(v,v)=(n-2)\operatorname{tr}(v^2)$ of $\mathfrak{so}(n)$ up to sign; with $\langle v,v\rangle=-\tfrac12\operatorname{tr}(v^2)=1$ this is exactly $2(n-2)$. **No property of $W$ or of $v$ beyond $\lVert v\rVert=1$ enters**, $v$ need not be an eigenvector and there need not be a $W$ at all. Verified at $10^{-12}$ for random unit elements of $\mathfrak{so}(n)$ at $n=5,6,9,12$. So the record's "the mass is $2(n-2)$ at every one" of four points understates it: it is an identity of the Killing form, not a coincidence of the points tested.

**The critical-point value.** $Q(W)=\theta W$ gives $W^\#v=\theta\lambda_{\min}v-\lambda_{\min}^2v$, hence $\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$.

**Measured** ([t2_u1.py](../scripts/reviewers/r321/t2_u1.py)) at $S^3\times S^3$, $S^4\times S^4$, $S^3\times S^5$, $S^5\times S^5$, $\mathbb{CP}^3$: identity residual $\le2\times10^{-16}$, mass exact, critical-point value to $\le1.5\times10^{-15}$. At three random non-critical Weyl points the identity and the mass still hold exactly while $\lambda_{\min}(\theta-\lambda_{\min})$ misses by $0.12$–$0.26$, as it must.

**The sign convention is right.** With $\mathrm{sharp}=-\tfrac12\operatorname{tr}(A_aWA_bW)$ and $Q=W^2+W^\#$, the balanced sphere product is critical at $\theta=\theta_0(n)$, residual $9\times10^{-16}$. With the sign flipped ($Q=W^2-W^\#$) the same point gives $P=-0.843274$ and criticality residual $0.516$, the convention is not merely conventional, and the recorded one is the correct one.

---

## U2, which block vanishes under which hypothesis. Both biconditionals REFUTED in the "only if" direction

### The correct characterisation, derived

Both blocks are sums of **nonnegative** terms, because $\lambda_a\lambda_b>0$ on $\mathfrak m\times\mathfrak m$ (two negatives) and on $\mathfrak p\times\mathfrak p$ (two positives). Using $c_{1ab}=\langle v,[\varphi_a,\varphi_b]\rangle$ by total antisymmetry of the Cartan form:

| block | vanishes **exactly** iff |
|---|---|
| $\mathfrak m\times\mathfrak m$ | $v\perp[\mathfrak m,\mathfrak m]$ |
| $\mathfrak p\times\mathfrak p$ | $v\perp[\mathfrak p,\mathfrak p]$ |

These are **one-vector slices**. $S_{\mathfrak{mmm}}=0$ is $\mathfrak m\perp[\mathfrak m,\mathfrak m]$ and $S_{\mathfrak{mpp}}=0$ is $\mathfrak m\perp[\mathfrak p,\mathfrak p]$, the same conditions with the whole of $\mathfrak m$ in place of the single vector $v$. So each hypothesis **implies** its block vanishing (the direction the route uses, and it is sound) and neither is implied by it. The record's "iff" is an over-claim in the direction that matters for any converse or rigidity step.

### Counterexample A, $S_{\mathfrak{mmm}}=84$ with the $\mathfrak m\times\mathfrak m$ block exactly $0$

A **genuine critical point**, $n=9$, diagonal, found by Newton on $\mathrm{proj}_V(M^{\circ2}+M^2)=\theta M$ over $V=\{$hollow, symmetric, zero row sums$\}$ and then re-verified in the full $\Lambda^2$ machinery ([t7_verify_ce.py](../scripts/reviewers/r321/t7_verify_ce.py), matrix at [ce_A_n9_M.npy](../scripts/reviewers/r321/ce_A_n9_M.npy)):

| | |
|---|---|
| $\theta$ | $0.297734184$, criticality residual $\lVert Q(W)-\theta W\rVert=1.7\times10^{-16}$ |
| $\dim(\mathfrak m,\mathfrak p,\ker)$ | $(21,15,0)$, $\lambda_{\min}=-0.276223774$ **simple** |
| $S_{\mathfrak{mmm}}$ | $\mathbf{84}$ (the negative graph has 21 triangles) |
| $\tfrac12\,\mathfrak m\times\mathfrak m$ | $\mathbf{0.000000000\times10^{0}}$, exactly zero, not small |
| $\mathfrak m\times\mathfrak p$ / $\tfrac12\,\mathfrak p\times\mathfrak p$ | $-0.159271453$ / $+7.306199\times10^{-4}$, summing to $\langle v,W^\#v\rangle=-0.158540833=\lambda_{\min}(\theta-\lambda_{\min})$ |

The mechanism is transparent in the diagonal model: $\lambda_{\min}$ sits on the edge $(2,6)$, which lies in **no** triangle of the negative graph, while 21 other triangles do exist elsewhere in $\mathfrak m$.

### Counterexample B, $S_{\mathfrak{mpp}}=24$ with the $\mathfrak p\times\mathfrak p$ block exactly $0$

$n=8$, diagonal, critical ([ce_B_n8_M.npy](../scripts/reviewers/r321/ce_B_n8_M.npy)):

| | |
|---|---|
| $\theta$ | $0.296338262$, criticality residual $3.2\times10^{-16}$ |
| $\dim(\mathfrak m,\mathfrak p,\ker)$ | $(19,9,0)$, $\lambda_{\min}=-0.268906556$ **simple**, on edge $(6,7)$ |
| $S_{\mathfrak{mpp}}$ | $\mathbf{24}$ |
| $\tfrac12\,\mathfrak p\times\mathfrak p$ | $\mathbf{0.000000000\times10^{0}}$ |
| also | $S_{\mathfrak{mmm}}=84$ with $\tfrac12\,\mathfrak m\times\mathfrak m=0$, a second instance of A |

**These are not rare.** A sweep of about a thousand diagonal critical points at $n=7,8,9,10$ ([t5_hunt.py](../scripts/reviewers/r321/t5_hunt.py)) returned **166** points of type A and **60** of type B. Any statement of the form "block vanishing detects $S=0$" is unusable.

### The surviving sums: one sign confirmed, one refuted

**$\mathfrak m$–$\mathfrak p$ strictly negative, CONFIRMED, with a proof.** On $\{v\perp[\mathfrak m,\mathfrak m]\}$ at a critical point, $\lambda_{\min}(\theta-\lambda_{\min})=B_{\mathfrak{mp}}+\tfrac12B_{\mathfrak{pp}}$ with $B_{\mathfrak{pp}}\ge0$, so $B_{\mathfrak{mp}}\le\lambda_{\min}(\theta-\lambda_{\min})$, which is strictly negative whenever $\theta>\lambda_{\min}$, in particular at every point with $\theta\ge0$. It cannot vanish there.

**$\mathfrak p$–$\mathfrak p$ strictly positive, REFUTED.** It is $0$ to machine precision at $S^3\times S^3$, $S^4\times S^4$, $S^3\times S^5$, $S^5\times S^5$, $S^4\times S^6$, $\mathbb{CP}^3$, $\mathbb{CP}^4$ and the $n=8$ witness. The correct statement is $\ge0$, with equality exactly on graded points. The record contradicts itself here: the sentence immediately after "strictly positive" says "on graded points the second sum vanishes too".

### The reported $1.00$ and $0.347$ do not reproduce, and cannot be right

Every block is a **conjugation invariant**: $\Lambda^2(g)$ for $g\in\mathrm{SO}(n)$ carries eigenvectors to eigenvectors, the bracket to the bracket, and $W^\#$ to $\Lambda^2(g)W^\#\Lambda^2(g)^{\mathsf T}$. So a point and its $\mathrm{SO}(10)$-conjugate must give **identical** block values, and $1.00$ against $0.347$ is impossible whichever is correct.

Rebuilding the $C_5$ blow-up from scratch, 5 blocks of 2, block-constant, solved for criticality, giving $\theta=0.6708203932499368=\sqrt{9/20}$, $\dim\mathfrak m=20$, $S_{\mathfrak{mpp}}=80$, all matching the record, I get at both the point and a random $\mathrm{SO}(10)$-conjugate of it:

$$\tfrac12\,\mathfrak p\times\mathfrak p=0.0111111\ldots=\tfrac1{90},\qquad \mathfrak p\times\mathfrak p=\tfrac1{45},\qquad \text{raw mass }\textstyle\sum_{a,b\in\mathfrak p}c_{1ab}^2=4.$$

The value is also exactly reproducible by hand: $\lambda_{\min}$ sits on an adjacent-block pair, the two vertices of the block opposite to both are its only common positive neighbours, giving $4$ ordered pairs each weighted $\gamma^2=(0.0745356)^2$. And it is **not** a choice-of-$v$ artefact either: the quadratic form $v\mapsto B_{\mathfrak{pp}}(v)$ restricted to the $20$-dimensional $\lambda_{\min}$ eigenspace has spectrum constant at $0.0222222$, so every unit $v$ there gives the same number. The record's qualitative claim (nonzero at the $C_5$ blow-up, zero at the graded points) stands; its two magnitudes do not, and their disagreeing with each other is itself the proof.

### Two scoping points the brief did not ask about

- **$v$ is not well defined.** $\lambda_{\min}$ is degenerate at every point in the record's catalogue except the $n=8$ witness, multiplicity $9,16,15,25,6,12,20$ at the listed points. The blocks are functions of the chosen $v$, so "the walk identity at the $\lambda_{\min}$ eigenvector" needs either a quantifier over the eigenspace or the observation (true at the points measured, false in general) that the restricted forms are scalar there.
- **The kernel is a fourth block.** $\Lambda^2=\mathfrak m\oplus\ker\oplus\mathfrak p$, so the three-block split is exhaustive only because kernel terms carry $\lambda=0$. Harmless for the identity, but it breaks the mass bookkeeping: at the padded points the record itself lists $\dim\ker=13$ and $25$, so $\sum_{\mathfrak{mm}}+2\sum_{\mathfrak{mp}}+\sum_{\mathfrak{pp}}<2(n-2)$ there.

---

## U3, the count cannot be completed in this form, and post F10 is not what blocks it

### First, what the identity does give: a new bound, sharp at the extremiser

Keeping the $\lambda_a\lambda_b\leftrightarrow c^2$ pairing and using only $\lvert\lambda_a\rvert\le\lvert\lambda_{\min}\rvert$ on $\mathfrak m$, $\lambda_b\le\lambda_{\max}$ on $\mathfrak p$, $B_{\mathfrak{pp}}\ge0$ and $\sum_{\mathfrak{mp}}c_{1ab}^2\le n-2$:

$$\boxed{\ \theta\ \le\ \lambda_{\min}+(n-2)\lambda_{\max}\ }$$

**It is an equality at the balanced sphere product in every dimension.** Slack $0.000000$ at $S^3\times S^3$, $S^4\times S^4$ and $S^5\times S^5$; algebraically, the balanced product has $\lambda_{\min}=-a$, $\lambda_{\max}=an/(n-2)$ with $a=\sqrt{2(n-2)/(n-1)}/n$, so the right side collapses to $a(n-1)=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$ exactly. Verified with $0$ violations at $309$ critical points ($n=6,7,8$ diagonal, plus the nine catalogued points), minimum slack $-2.2\times10^{-16}$.

### Why it does not close, and why the hypothesis is the wrong tool, three obstructions

**(O1) The sign is inverted relative to Nosal.** Write the identity as $\theta=\lambda_{\min}+\langle v,W^\#v\rangle/\lambda_{\min}$. Since $\lambda_{\min}<0$, **every nonnegative term on the right lowers $\theta$**. The $\mathfrak m\times\mathfrak m$ block is nonnegative, so $S_{\mathfrak{mmm}}=0$ *deletes a term that was helping* and raises the attainable $\theta$. In Nosal's proof triangle-freeness deletes terms from an *upper* bound on $\lambda_1^2$; here the analogous deletion is anti-conservative. Concretely: the boxed bound above holds **with or without** $S_{\mathfrak{mmm}}=0$ (the derivation drops $B_{\mathfrak{mm}}\ge0$ exactly as it drops $B_{\mathfrak{pp}}\ge0$) so the truncation is never used. Moving to the $\lambda_{\max}$ eigenvector to fix the sign does not help: the block that then needs killing is $\langle\mathfrak p,[\mathfrak m,\mathfrak m]\rangle$, which $S_{\mathfrak{mmm}}=0$ leaves untouched and which is *maximal* at the sphere product.

**(O2) $S_{\mathfrak{mmm}}=0$ is an inactive constraint for any bound built from the spectrum plus the Cartan third-moment data.** Summing the criticality identity over the eigenbasis with weight $\lambda_a$ gives, with $t_{abc}=c_{abc}^2$ on unordered triples,

$$\theta=\operatorname{tr}W^3+3\!\!\sum_{\{a,b,c\}}\!\!\lambda_a\lambda_b\lambda_c\,t_{abc}.$$

Triples inside $\mathfrak m\times\mathfrak m\times\mathfrak m$ carry $\lambda_a\lambda_b\lambda_c<0$ (a **strictly negative objective coefficient**) so a maximiser of $\theta$ over the $t$-data sets them to zero of its own accord. Measured ([t10_inert.py](../scripts/reviewers/r321/t10_inert.py)): at the sphere-product spectrum and at every sampled spectrum with positive optimum, the unconstrained LP optimum already carries mass $0.000\times10^{0}$ on $\mathfrak m\times\mathfrak m\times\mathfrak m$. The hypothesis constrains only variables the extremal configuration has already switched off.

**(O3) The whole remaining gap is the spectrum, and nothing here bounds it.** Take the strongest honest version of R13's step 1: *all* $N$ criticality identities (not just the one at $v$), full pairing kept (no marginal relaxation anywhere), $t\ge0$ totally symmetric with per-index mass $n-2$, the $S_{\mathfrak{mmm}}=0$ support condition imposed, and Lemma L36's cap $\dim\mathfrak m\le\lfloor n^2/4\rfloor$. Maximise $\theta$ ([t6_lp.py](../scripts/reviewers/r321/t6_lp.py), [t8_ceiling.py](../scripts/reviewers/r321/t8_ceiling.py), [t11_n8.py](../scripts/reviewers/r321/t11_n8.py)):

| | result |
|---|---|
| at the balanced-product spectrum, $n=6,8,10$ | $\theta\le1.054092553389$, $1.145643923739$, $1.200000000000$, **exactly $\theta_0(n)$**, and identical with $S_{\mathfrak{mmm}}=0$ dropped |
| maximised over spectra at $n=6$, $\dim\mathfrak m\le9$ | ceiling $\ge\mathbf{1.202610}$ against $\theta_0(6)=1.054093$, $14\%$ over |
| the same ceiling with $S_{\mathfrak{mmm}}=0$ **removed** | $1.202610$ at every $\dim\mathfrak m$ from 2 to 9, agreeing to six decimals |

So the identity family is **not lossy at the right spectrum**, it proves $\theta\le\theta_0(n)$ outright once the spectrum is the balanced-product one, with no frame-realizability and no $S_{\mathfrak{mmm}}=0$, and the entire residual gap is that nothing in this data constrains $\lambda_{\max}$. Lemma L36 caps $\dim\mathfrak m$ and says nothing about $\lambda_{\max}$; the sup of $\lambda_{\min}+(n-2)\lambda_{\max}$ over $\{\sum\lambda=0,\sum\lambda^2=1,\dim\mathfrak m\le\lfloor n^2/4\rfloor\}$ is $n-2$, and its value at the $C_5$ blow-up is already $2.236068$ against $\theta_0(10)=1.2$.

### Does post F10 bite? No, it merely resembles the obstruction

The class just tested is **outside** fence post F10: it never relaxes alignment into marginals, it carries the full three-index tensor with its per-index row sums. It beats post F10's recorded $1.6059$ comfortably, $1.2026$ at $n=6$, and still fails. So "the count must keep the pairing" is right that pairing is worth $25\%$ and wrong that pairing is what is missing. What is missing is (i) any active use of the hypothesis, per O1/O2, and (ii) a spectral constraint. Post F10 is a real fence, but this route dies inside it rather than at it.

### One more scoping fact: the Nosal-shaped target statement is false as stated

The natural transfer is "$\theta\le h(\dim\mathfrak m)$ with $h$ increasing and $h(\lfloor n^2/4\rfloor)=\theta_0(n)$", the analogue of $\lambda_1\le\sqrt m$ closed by Mantel. **This is false at $n=6$:** $\mathbb{CP}^3$ has $\dim\mathfrak m=6$ and $\theta=\theta_0(6)=\sqrt{10/9}$ exactly, while $S^3\times S^3$ has $\dim\mathfrak m=9$ and the same $\theta$ (reproduced here independently; the record notes the coincidence in [findings/INDEX.md](../findings/INDEX.md)). So $h$ would have to be constant on $[6,9]$, and any proof of this shape cannot be dimension-uniform.

### What a successor must clear

1. **Make the hypothesis active.** $S_{\mathfrak{mmm}}=0$ with trivial kernel says $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$, which *moves* mass into the $\mathfrak m\mathfrak m\mathfrak p$ triples, and those carry $\lambda_a\lambda_b\lambda_c>0$, so in the third-moment model the hypothesis strictly **raises** the ceiling. Any successor must extract its gain from the frame-realizability that this containment forces, not from the deletion of the $\mathfrak m\times\mathfrak m$ term. A bound that gets weaker when the hypothesis is assumed is not a proof of it.
2. **Bound $\lambda_{\max}$, or bound $\lambda_{\min}+(n-2)\lambda_{\max}$ directly.** The boxed inequality already reaches $\theta_0(n)$ with equality at the conjectured extremiser, so the whole conjecture on $\{S_{\mathfrak{mmm}}=0\}$ reduces to that one spectral statement. That is a clean, named, and currently open sub-problem, and it is the only thing O3 leaves standing.
3. **Explain $\mathbb{CP}^3$**, or restrict the target statement to $n\ge12$ from the outset.

---

## Verdicts

| | |
|---|---|
| **U1** | **CONFIRMED.** All three parts derived from the definitions; the mass $2(n-2)$ is the Killing form of $\mathfrak{so}(n)$, exact and universal for any unit $v$, with no $W$ and no eigenvector hypothesis. The sign convention of sharp is correct, flipping it destroys criticality at the sphere product (residual $0.516$). |
| **U2** | **REFUTED** as a pair of biconditionals. The "if" directions hold; both "only if" directions fail at genuine critical points ($n=9$, $S_{\mathfrak{mmm}}=84$, $\mathfrak m\times\mathfrak m=0$; $n=8$, $S_{\mathfrak{mpp}}=24$, $\mathfrak p\times\mathfrak p=0$; 226 such points found). The correct conditions are the one-vector slices $v\perp[\mathfrak m,\mathfrak m]$ and $v\perp[\mathfrak p,\mathfrak p]$. "$\mathfrak m$–$\mathfrak p$ strictly negative" confirmed and proved; "$\mathfrak p$–$\mathfrak p$ strictly positive" refuted (it is $0$ at every graded point). The reported $1.00$/$0.347$ at the $C_5$ blow-up and its conjugate are refuted on invariance grounds; both are $1/90$. |
| **U3** | **REFUTED as posed**, the count does not complete in this form, and the named obstruction is misidentified. The truncation is anti-conservative (O1), the hypothesis is an inactive constraint on the third-moment data (O2), and the residual gap is a missing spectral bound (O3), with the pairing-preserving ceiling at $1.2026$ against $\theta_0(6)=1.0541$. Salvage: the identity yields $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$, an equality at the balanced product in every dimension, which reduces the conjecture on $\{S_{\mathfrak{mmm}}=0\}$ to one spectral inequality. |
