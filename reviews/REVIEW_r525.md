# Review r525, Observation L3

**Target.** `Observation L3`, "local maximality of the sphere pair off the diagonal locus", `findings/second-order.md`, at the `#### Observation L3` heading (line 31), down to the next heading.

**Reviewer.** r525, independent adversarial auditor, cold read. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts; screening only, labelled as screening.

**Phase plan.**

1. Setup (log + this file).
2. Read the target block verbatim.
3. Fix conventions against `findings/conventions.md`; read `INDEX-results.md`, `INDEX-traps.md`.
4. Central question: do Lemma L27 + Lemma L24 (+ L120) subsume L3? Derive, do not assume.
5. Dimension range: block says $n=6..12$; `report/sections/09-status.tex` says $n=6..16$. Which is wrong.
6. The 7 citations: verified-at-dimensions vs general fact.
7. Contradiction sweep: later sections of `second-order.md`, and `findings/` restatements at other dimensions.
8. Verdict.

**VERDICT: REFUTED**, false at $n=6$ ($S^3\times S^3$ is a degenerate saddle); and at every even $n\ge8$ it is under-claimed, being proved outright by L24 + L27. Detail below.

---

## Findings

(appended as found)
### F1, the heading promises a proof the block does not contain

The heading reads `#### Observation L3 (local maximality of the sphere pair off the diagonal locus), canonical statement and proof`. The body is one provenance italic plus **three sentences**, of which the middle one is the whole claim: *"$W^*=S^{n/2}\times S^{n/2}$ is a genuine local max off the diagonal locus too, confirmed by full Hessian diagonalization for $n=6,\dots,12$."* There is no statement environment, no proof, no definition of which Hessian was diagonalised, on which space, or what "genuine local max" is taken to exclude. The suffix *"canonical statement and proof"* is the record's own marker for a block that carries an argument; here it is a false advertisement of the same kind [L7](../findings/bounds.md) was pulled up for ("the block having carried an ingredient list under a *canonical statement and proof* heading", [INDEX-results.md](../findings/INDEX-results.md) row 7).

### F2, conventions fixed, and the anchors reproduce

Rebuilt cold from [conventions.md](../findings/conventions.md): $\theta_0(n)^2=2(n-1)(n-2)/n^2$ gives $\theta_0(6)^2=40/36=10/9$, so $\theta_0(6)=\sqrt{10}/3$, the brief's anchor. $\dim\mathcal W_6=6\cdot3\cdot7\cdot8/12=84$, matches the record. Half-trace pairing, $\lVert\varphi_{ab}\rVert^2=1$. All four anchors hold; nothing below turns on a normalisation.

### F3, the Hessian in L24 is the right one (the brief's trap does not bite here)

$\nabla P=3Q(W)=3\theta W$ and the ambient second differential is $6\theta L_e$. Along the sphere geodesic $\gamma(t)=\cos t\,W+\sin t\,X$ one has $\gamma''(0)=-W$, so
$$\mathrm{Hess}_S P(X,X)=D^2P(X,X)-\langle\nabla P,W\rangle\lVert X\rVert^2=6\theta\langle X,L_eX\rangle-3\theta\lVert X\rVert^2,$$
i.e. $\mathrm{Hess}_SP=6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$ on $T_W S=W^\perp$. Derived cold; it agrees with [Lemma L24](../findings/second-order.md). The correction term is $-3\theta\,\mathrm{Id}$, which is **never** zero at a critical point with $\theta>0$, so the Riemannian/ambient discrepancy the brief warns of is present, accounted for, and is exactly the source of the $\tfrac12$. **CONFIRMED for L24; no defect.**

### F4, THE REFUTATION. The claim is FALSE at $n=6$, and the record's own file says so four times

L3's range is $n=6,\dots,12$, and at $n=6$ the object $W^*=S^{n/2}\times S^{n/2}$ **is $S^3\times S^3$**. The record states, in five places, that $S^3\times S^3$ is not a local maximum:

| where | what it says |
| --- | --- |
| [nondegeneracy.md:347](../findings/nondegeneracy.md) | "$S^3\times S^3$ is a **degenerate saddle, not a local maximum**: zero positive Hessian directions, but $\theta$ takes both signs at cubic order on the $9$ null directions transverse to the orbit" |
| [second-order.md:121](../findings/second-order.md) | "its failure at $S^3\times S^3$ says exactly that $S^3\times S^3$ is not a local maximum of $P$ … Both reviewers refuted the point directly from the definition, **exhibiting a curve with $P(\gamma(t))>\theta$**" |
| [second-order.md:171](../findings/second-order.md) | "$S^3\times S^3$ fails the third-order condition, so it is not a local maximum and the Peirce table there describes a saddle" |
| [second-order.md:191](../findings/second-order.md) | "the two catalogued points that carry excess each fail to be maxima … $S^3\times S^3$ fails the third-order condition" |
| [fence-posts.md:193](../findings/fence-posts.md) | "as a test of local maximality it is strictly stronger than the second-order tool, **killing $S^3\times S^3$ where $\lambda_{\max}\le\tfrac12$ holds exactly**" |

[second-order.md:121](../findings/second-order.md) sits **90 lines below the L3 block, in the same file.** This is the pattern the brief names: a result refuted by a passage beneath it.

**Derived cold, so the report does not rest on the record's word.** Let $v\perp W$ be a unit Hessian null direction, i.e. $L_ev=\tfrac12v$, and take the sphere geodesic $\gamma(t)=\cos t\,W+\sin t\,v$. With $T$ the symmetric trilinear form of the cubic ($T(X,X,X)=P(X)$, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$),
$$P(\gamma(t))=\cos^3t\,\theta+3\cos^2t\sin t\,\langle Q(W),v\rangle+3\cos t\sin^2t\,\theta\langle L_ev,v\rangle+\sin^3t\,T(v,v,v).$$
The linear term vanishes by criticality ($Q(W)=\theta W\perp v$). The quadratic terms cancel exactly, $\cos^3t\,\theta\approx\theta-\tfrac32\theta t^2$ against $3\cos t\sin^2t\cdot\tfrac\theta2\approx+\tfrac32\theta t^2$, which is what "null direction" means. So
$$\boxed{\,P(\gamma(t))=\theta+T(v,v,v)\,t^3+O(t^4).\,}$$
**A cubic in $t$ takes both signs**, so $T(v,v,v)\ne0$ for even one such $v$ refutes local maximality outright. That is exactly the third-order condition the record calls the fusion rule, and exactly the quantity it measures as nonzero at $S^3\times S^3$.

**Why $n=6$ and nowhere else, symbolically.** At the balanced product $p=q=m=n/2$, [Lemma L27](../findings/nondegeneracy.md)'s ten $L_e$-eigenvalues give, off the orbit summand, largest value $\max\big(\lambda_m,\mu\big)$ with $\lambda_m=\frac{m-2}{2(m-1)}$ and $\mu=\frac{n-2}{2(m-1)^2}=\frac1{m-1}$. Hence
$$\tfrac12-\lambda_m=\frac1{2(m-1)},\qquad \tfrac12-\mu=\frac{m-3}{2(m-1)},$$
the second reproducing L27's $\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ at $p=q=m$, an independent check of that closed form. The **spectral gap below $\tfrac12$ transverse to the orbit is**
$$g(m)=\frac{\min(1,\,m-3)}{2(m-1)},$$
which is **$>0$ for $m\ge4$ and exactly $0$ at $m=3$.** So $n=6$ is precisely the dimension at which the Hessian stops being negative definite transverse to the orbit, and it is the lowest dimension in L3's own stated range.

### F5, THE UNDER-CLAIM. At every even $n\ge8$ the record now PROVES L3, and the numerical warrant is redundant

**The proof, in three steps, none of them numerical.**

1. **[Lemma L24](../findings/second-order.md)**, re-derived at F3 above: $\mathrm{Hess}_SP=6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$ on $T_WS=W^\perp$, with $\theta=\theta_0(n)>0$ at the sphere product.
2. **[Lemma L27](../findings/nondegeneracy.md)**, symbolic in $p,q$: for $p,q\ge3$, $(p,q)\ne(3,3)$, $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ **attained exactly on the orbit tangent** $\mathbb R^p\otimes\mathbb R^q$. Balanced $n\ge8$ even gives $p=q=n/2\ge4$, inside the hypothesis.
3. Therefore $\mathrm{Hess}_SP\preceq0$ with $\ker=T_W\mathcal O$, and on the orthocomplement of $T_W\mathcal O$ inside $W^\perp$, by F4's gap, $\mathrm{Hess}_SP\preceq-6\theta\,g(n/2)\,\mathrm{Id}=-\frac{3\theta\min(1,\tfrac n2-3)}{\tfrac n2-1}\,\mathrm{Id}\prec0$. $P$ is $O(n)$-invariant and constant on the compact orbit $\mathcal O$, so in a slice transverse to $\mathcal O$ the point is a **strict** local maximum. Hence $P(X)\le\theta_0(n)$ near $W^*$ with equality only on $\mathcal O$: $W^*$ is a local maximum of $P$ on the unit sphere of $\mathcal W_n$, the full space, not the diagonal slice. $\square$

This is the standard Morse–Bott statement and uses no computation. **It holds at every even $n\ge8$ with no upper cut-off**, so the ranges $6..12$ and $6..16$ are both redundant above $6$ and both wrong at $6$. The record already half-knows this: [report/sections/07-gradedness-split.tex:611](../report/sections/07-gradedness-split.tex) says "Observation~3's nondegeneracy claim is a scan … Two lemmas close that", and [results.md:114](../results.md) predicted the route, *"the same Schur mechanism should derive this one"*. It did; L27 **is** that Schur mechanism, and the prediction was never cashed back into L3's label.

### F6, THE DIMENSION RANGE. Both numbers are on file, and results.md contradicts itself

| file | line | range |
| --- | --- | --- |
| [findings/second-order.md:35](../findings/second-order.md), the canonical block | 35 | $n=6,\dots,12$ |
| [results.md:306](../results.md), the mirror block | 306 | $n=6,\dots,12$ |
| [results.md:114](../results.md), the summary bullet | 114 | $n=6,\dots,16$ |
| [report/sections/09-status.tex:28](../report/sections/09-status.tex) | 28 | $n=6,\dots,16$ |

**[results.md](../results.md) carries both numbers, 192 lines apart**, so the divergence is not merely findings-versus-report and cannot be resolved by the "findings is canonical" rule alone. Auditing which computation was actually run is barred by the analysis-only footing and, per F5, is moot: the correct statement names no range. **Two further defects in the range as written.** $W^*=S^{n/2}\times S^{n/2}$ exists only at even $n$, [results.md:88](../results.md) says so itself, yet "$n=6,\dots,12$" reads over all integers; and $n=16$ was never reachable by "full Hessian diagonalization", $\dim\mathcal W_{16}=\frac{16\cdot13\cdot17\cdot18}{12}=5304$, against $\dim\mathcal W_{12}=1638$.

### F7, "off the diagonal locus" names the wrong set, and the block never states the distinction

$W^*$ is coordinate-diagonal, [results.md:314](../results.md) says so in as many words ("that is exactly why $S^3\times S^3$ *is* diagonal"), so $W^*$ **lies in** the diagonal locus and there is no sense in which it is a local maximum "off" it. What is meant, and what the first sentence gestures at, is *a local maximum of $P$ on the unit sphere of $\mathcal W_n$, rather than only on the sphere of the diagonal slice $\mathcal D_n$, which is all [Lemma L57](../findings/problem.md) reaches.* The block never writes that sentence, never names $\mathcal D_n$, and never says which Hessian was diagonalised or on what space. A reader cannot tell from the block whether the computation was the ambient Hessian, the Riemannian one, or the one restricted to $\mathcal D_n$, and the three differ (F3).

### F8, the 7 citations: none treats L3 as proved, two miscall it a different statement

| # | site | how it uses L3 | safe? |
| --- | --- | --- | --- |
| 1 | [results.md:88](../results.md) | "Observation L3's Hessian check [is] parity-free in its *integer* conclusion" | as a numerical check, **safe**, though at odd $n$ the object is $S^m\times S^{m+1}$, not $W^*$ |
| 2 | [results.md:114](../results.md) | "Machine-verified by full Hessian diagonalization at $n=6,\dots,16$" | verified-at-dimensions, **safe as to label**, wrong range (F6) |
| 3 | [results.md:306](../results.md) | the mirror block | inherits F4, F6, F7 |
| 4 | [findings/nondegeneracy.md:82](../findings/nondegeneracy.md) | "Observation L3's **nondegeneracy claim** at $S^p\times S^q$ rested on a scan" | **safe** (motivating L26), but **miscalls the statement** |
| 5 | [findings/LEDGER.md:624](../findings/LEDGER.md) | provenance bookkeeping only | **safe**, no mathematical use |
| 6 | [report/sections/09-status.tex:28](../report/sections/09-status.tex) | "Verified … $n=6,\dots,16$; Hessian derivation awaiting audit" | label correct, **safe**; the "awaiting audit" is discharged by F5 |
| 7 | [report/sections/07-gradedness-split.tex:611](../report/sections/07-gradedness-split.tex) | "Observation~3's **nondegeneracy claim** is a scan … Two lemmas close that" | **safe**, and closest to right; same miscall |

**Nothing cites L3 as a Lemma, and nothing relies on the wider $n\le16$ range for a mathematical step**, the two report citations are status prose. So the [L15](../findings/problem.md) failure mode (Lemmas resting on a downgraded Observation) does **not** occur here. **The recurring error instead runs the other way**: sites 4 and 7 both call L3 a *nondegeneracy* claim. Nondegeneracy is $\dim E(\tfrac12)=\dim\mathcal O$; local maximality is $\mathrm{Hess}\preceq0$. Neither implies the other, [nondegeneracy.md:668](../findings/nondegeneracy.md) records the exact witness, *"$S^2\times S^q$ is nondegenerate, but … it is not a local maximum"*, and $S^3\times S^3$ is the converse pairing (degenerate, and this file once counted it a maximum). L3 says local maximality; only L27 says nondegeneracy.

### F9, "full Hessian diagonalization" cannot support the conclusion it is cited for, at $n=6$

A Hessian spectrum decides local maximality only when it is definite transverse to the known flat directions. At $n=6$ it is not: $\dim E(\tfrac12)=18$ against $\dim\mathcal O=9$ ([nondegeneracy.md:442, 457ff](../findings/nondegeneracy.md), and the retracted-quotient paragraph at [second-order.md:23](../findings/second-order.md)), leaving **nine null directions with no group origin**. Diagonalizing there returns $\lambda_{\max}=\tfrac12$ exactly, the record measures $\min\mathop{\mathrm{spec}}(\tfrac\theta2-L_W)|_{W^\perp}=-9.5\times10^{-16}$, which is the second-order test **returning no verdict**, and the block reads that as a confirmation. **This is the load-bearing methodological error**: the $n=6$ entry of "confirmed for $n=6,\dots,12$" was a null result recorded as a positive one, and F4's third order is what actually decides it, against the block.

---

## VERDICT: REFUTED

**Broken step.** The sentence *"$W^*=S^{n/2}\times S^{n/2}$ is a genuine local max off the diagonal locus too, confirmed by full Hessian diagonalization for $n=6,\dots,12$"* is **false at $n=6$**, where $W^*=S^3\times S^3$ is a degenerate saddle: nine Hessian null directions transverse to the orbit on which $P$ rises at order $t^3$ (F4). The record holds the witness curve in five places, one of them 90 lines below the block in the same file. The $n=6$ warrant is a degenerate Hessian misread as a positive verdict (F9).

**And the surviving claim is under-claimed: it is a Lemma, not an Observation.** For every even $n\ge8$, [Lemma L24](../findings/second-order.md) + [Lemma L27](../findings/nondegeneracy.md) prove it symbolically, with an explicit transverse gap $\mathrm{Hess}_SP\preceq-\frac{3\theta\min(1,\tfrac n2-3)}{\tfrac n2-1}$ off the orbit tangent (F5). No computation is needed, no upper bound on $n$ arises, and the numerical warrant is redundant.

**The repair, in one sentence.** Replace the block with: *For every even $n\ge8$, $W^*=S^{n/2}\times S^{n/2}$ is a local maximum of $P$ on the unit sphere of $\mathcal W_n$ (not merely within the diagonal locus $\mathcal D_n$), strictly so transverse to its $O(n)$-orbit, by [L24](../findings/second-order.md) and [L27](../findings/nondegeneracy.md); at $n=6$ the statement is false, $S^3\times S^3$ being a degenerate saddle killed at third order.* Relabel **Lemma**, and delete the dimension range from L3, from [results.md:114](../results.md) and [306](../results.md), and from [report/sections/09-status.tex:28](../report/sections/09-status.tex).

**Downstream.** The block's third sentence (*"So $n\ge12$ is about which of two local maxima wins globally"*), survives untouched, since $n\ge12$ is inside the proved range. None of the 7 citations breaks (F8); two should stop calling L3 a nondegeneracy claim.

**Compute.** None run. Every step above is symbolic; the one point that would need a run, which of $6..12$ and $6..16$ was actually executed, is moot under the repair and is left unrun per the analysis-only rule.
