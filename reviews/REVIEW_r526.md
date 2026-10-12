# REVIEW r526, Observation L3

**Target:** `Observation L3`, "local maximality of the sphere pair off the diagonal locus", `findings/second-order.md`, at the `#### Observation L3` heading (line 31), down to the next heading.

**Reviewer:** r526, cold brief, analysis-only footing (no searches/sweeps/censuses; screening only).

**Phase plan:**
1. Fix conventions against `findings/conventions.md`, `findings/INDEX-results.md`, `findings/INDEX-traps.md`.
2. Read L3 verbatim.
3. Derive: does L27 + L24 (+ L120) subsume L3 into a Lemma?
4. Dimension range: block says n=6..12; `report/sections/09-status.tex` says n=6..16.
5. "Off the diagonal locus": local max in W_n vs within the diagonal slice; Riemannian vs ambient Hessian.
6. "Full Hessian diagonalization": what space, and Morse–Bott nondegeneracy vs strict local maximality.
7. The 7 citations: verified-at-dimensions vs general fact.
8. Restatements elsewhere in `findings/`; later sections of `second-order.md` contradicting the block.
9. Verdict.

VERDICT: **REFUTED** (at n=6, the lower endpoint of its own range), and simultaneously **under-claimed** at every even n>=8, where L27+L24 prove it. See the verdict section at the foot.

## Findings

(appended as found)

### F1, The block verbatim, and what it actually contains

The heading is `#### Observation L3 (local maximality of the sphere pair off the diagonal locus), canonical statement and proof`. The body, in full, is:

> *Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result.*
>
> Needed because the known diagonal-case proof can't see whether $W^*$'s criticality survives off-diagonal. $W^*=S^{n/2}\times S^{n/2}$ is a genuine local max off the diagonal locus too, confirmed by full Hessian diagonalization for $n=6,\dots,12$. So $n\geq12$ is about which of two local maxima wins globally, not about $W^*$ losing local maximality.

**The heading promises "canonical statement and proof". There is no proof, no statement of what "local max" is with respect to, no naming of the space the Hessian acts on, and no reference to the run.** Every sibling block in this file (L24, L125, L27, L28) carries a **Statement** and an **Argument**. This one carries three sentences of assertion. That alone is a structural defect: the heading is a promise the block does not keep.

### F2, L27 subsumes L3 at every even $n\ge8$, and the record is under-claiming there

[Lemma L27](../findings/nondegeneracy.md) gives the **complete** spectrum of $L_e$ at $W_{p,q}$, symbolically in $p,q$, via Nienhaus's ten-summand multiplicity-free decomposition:

| summand | dim | $L_e$ eigenvalue |
| --- | --- | --- |
| $\langle W\rangle$ | $1$ | $1$ |
| $\mathbb R^p\otimes\mathbb R^q$ (orbit tangent) | $pq$ | $\tfrac12$ |
| $S^2_0(\mathbb R^m)$, $m=p,q$ | $\tfrac{m(m+1)}2-1$ each | $\lambda_m=\frac{m-2}{2(m-1)}<\tfrac12$ |
| $S^2_0\otimes S^2_0$ |, | $-\mu$ |
| $\Lambda^2\otimes\Lambda^2$ |, | $+\mu$, $\mu=\frac{n-2}{2(p-1)(q-1)}$ |
| $\mathrm{Weyl}_p,\ \mathrm{Weyl}_q,\ X_p\otimes\mathbb R^q,\ X_q\otimes\mathbb R^p$ |, | $0$ |

with $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ for $p,q\ge3$, $(p,q)\ne(3,3)$.

The Hessian of $P$ on the unit sphere of $\mathcal W_n$ is $6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, that is [Lemma L24](../findings/second-order.md), stated for the **whole** of $\mathcal W_n$, not for a slice. So at the balanced product with $p=q=n/2\ge4$:

- the Hessian is **zero exactly on the $pq$-dimensional orbit tangent**;
- it is **strictly negative on the orthogonal complement of the orbit inside $W^\perp$**, with spectral gap $6\theta\cdot\min\{\tfrac12-\lambda_{k},\ \tfrac12-\mu\}=\dfrac{6\theta}{n-2}$ at $k=p=q=n/2\ge4$, since $\tfrac12-\lambda_k=\frac1{2(k-1)}$ and $\tfrac12-\mu=\frac{k-3}{2(k-1)}$, whose minimum is $\frac1{2(k-1)}=\frac1{n-2}$ for every $k\ge4$, matching [Lemma L26](../findings/nondegeneracy.md)'s own $1/(2\max(p,q)-2)$;
- $P$ is constant along the orbit, being $O(n)$-invariant.

That is precisely the Morse–Bott hypothesis, and the Morse–Bott lemma gives a **local maximum of $P$ on the unit sphere of $\mathcal W_n$**, attained on the whole orbit and strict transverse to it. **This is a proof, symbolic in $n$, for every even $n\ge8$, no dimension range, no numerics.** It is stronger than L3 in three ways: it holds at every even $n\ge8$ rather than $n\le12$; it is analytic rather than numerical; and it comes with an explicit transverse gap.

**Verdict on this half: L3 is under-claimed at $n\ge8$ and its numerical warrant there is redundant.** L24 alone does *not* suffice, L24 is a *necessary* condition at a maximiser, and $W^*$ is not known to be a maximiser, so L24 cannot be applied to it. The work is done by L27, whose spectrum is computed at $W_{p,q}$ directly; L24 supplies only the identification $\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})$.

**One clarification the label hides.** L27's headline word is "Morse–Bott nondegenerate", and Morse–Bott nondegeneracy alone would *not* give local maximality, it constrains only the kernel, not the signs. But L27's **statement** says more than its label: $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$, *attained exactly on the orbit tangent*. That is the sign as well as the kernel, and it is what turns nondegeneracy into local maximality. The record's own [Lemma L28](../findings/nondegeneracy.md) is the control: $\mathbb{CP}^m$ is Morse–Bott nondegenerate *and not a maximiser*, because there $\lambda_{\max}=\tfrac{m+2}{2(m+1)}>\tfrac12$.

**The Hessian is the right one.** I re-derived it cold rather than taking L24. For $z\perp W$ unit with $L_ez=\lambda z$, the great circle $\gamma(t)=W\cos t+z\sin t$ stays in $\mathcal W_n$, and with $T$ the fully symmetric trilinear form ($T(W,W,z)=\langle Q(W),z\rangle=0$ by criticality, $T(W,z,z)=\theta\lambda$):

$$P(\gamma(t))=\theta\cos^3t+3\theta\lambda\cos t\sin^2t+P(z)\sin^3t,\qquad \tfrac{d^2}{dt^2}P(\gamma)\big\vert_0=6\theta\big(\lambda-\tfrac12\big).$$

So L24's operator **is** the geodesic (Riemannian) Hessian on the sphere; the multiplier term $-3\theta\,\mathrm{Id}$ is exactly the second fundamental form's contribution, and no ambient/Riemannian discrepancy survives here. Brief item 2's worry is clean at this point.

### F3, **L3 IS FALSE AT $n=6$, THE LOWER ENDPOINT OF ITS OWN RANGE**, and the record says so in three places

At $n=6$ the sphere pair is $W^*=S^3\times S^3$, exactly the $(p,q)=(3,3)$ case [Lemma L27](../findings/nondegeneracy.md) excludes, where $\mu=\tfrac12$ and $\dim E(\tfrac12)=18$ against an orbit of $9$. The Hessian therefore has **nine null directions transverse to the orbit**, and second-order data decides nothing. Take the exact formula above with $\lambda=\tfrac12$:

$$P(\gamma(t))=\theta\cos t\big(1+\tfrac12\sin^2t\big)+P(z)\sin^3t=\theta\Big(1-\tfrac38t^4\Big)+P(z)\,t^3+O(t^5).$$

**So if $P(z)=T(z,z,z)\ne0$ for a single transverse null direction $z$, then choosing the sign of $t$ with $P(z)t^3>0$ gives $P(\gamma(t))>\theta$ and $W^*$ is not a local maximum.** Three independent confirmations that $P(z)\ne0$ at $n=6$:

1. **[findings/second-order.md:121](../findings/second-order.md)**, ninety lines *below* the L3 block, in the same file: *"It is the **third-order necessary condition for a local maximum**, and its failure at $S^3\times S^3$ says exactly that $S^3\times S^3$ is not a local maximum of $P$, consistent with $\lambda_{\max}=\tfrac12$ there, because second order is degenerate at that point and third order is what decides. Both reviewers refuted the point directly from the definition, exhibiting a curve with $P(\gamma(t))>\theta$ tracking the $\sigma t^3$ prediction."* The same section's table records $S^3\times S^3$: $B\succeq0$ yes, excess $9$, **fusion rule fails, $\max\lvert T\rvert=0.395$**; and at line 171, *"the Peirce table there describes a saddle"*.
2. **[findings/nondegeneracy.md:347](../findings/nondegeneracy.md)**, *"$S^3\times S^3$ is a **degenerate saddle, not a local maximum**: zero positive Hessian directions, but $\theta$ takes both signs at cubic order on the $9$ null directions transverse to the orbit."*
3. **[report/sections/09-status.tex:85](../report/sections/09-status.tex)**, *"$S^3\times S^3$ is a degenerate saddle --- no positive Hessian direction, but $\theta$ signs both ways at cubic order on the $9$ transverse null directions."* This sits **57 lines below line 28 of the same file**, which reads *"Local maximality of $W^{*}$ (Obs.~3) & Verified & $n=6,\dots,16$"*. One file, two lines, flat contradiction.

**My own analytic corroboration, which does not use any of the three.** Two facts, derived cold:

- **The third-order term vanishes identically on the orbit tangent, with no hypothesis.** $\mathfrak{so}(n)$ acts on $\mathcal W_n$ by orthogonal algebra automorphisms, so each $D\in\mathfrak{so}(n)$ acts as a *skew-adjoint derivation* of $\circ$, and $T$ is $D$-invariant: $T(DX,Y,Z)+T(X,DY,Z)+T(X,Y,DZ)=0$. Put $z=DW$. Taking $(X,Y,Z)=(z,z,W)$ gives $2T(D^2W,z,W)+T(z,z,z)=0$; and $T(\cdot,z,W)=\theta\langle\cdot,L_ez\rangle=\tfrac\theta2\langle\cdot,z\rangle$ since $z$ is a $\tfrac12$-eigenvector, so $T(z,z,z)=-\theta\langle D^2W,DW\rangle=+\theta\langle DW,D^2W\rangle=0$ by skewness. **So the cubic obstruction is carried by the excess alone**, which is second-order.md's own $T(z,z,z)=T(e,e,e)$, reached by a different route.
- **Representation theory *permits* a nonzero cubic on the $(3,3)$ excess and *forbids* one on the orbit summand, precisely the asymmetry measured.** Under $O(3)$, $\Lambda^2\mathbb R^3\cong\mathbb R^3\otimes\det$. So the excess summand is $\Lambda^2\otimes\Lambda^2\cong(\mathbb R^3\otimes\det)\boxtimes(\mathbb R^3\otimes\det)$, on which $O(3)\times O(3)$ acts by $M\mapsto\det(g)\det(h)\,gMh^{\mathsf T}$; then $\det\!\big(\det(g)\det(h)gMh^{\mathsf T}\big)=(\det g\det h)^4\det M=\det M$, so $\det M$ **is** an invariant cubic and $P\vert_{\text{excess}}=c\det M$ with $c$ unconstrained by symmetry. On the orbit summand $\mathbb R^3\boxtimes\mathbb R^3$, untwisted, $\det(gMh^{\mathsf T})=\det g\det h\det M$ changes sign, so the only invariant cubic is $0$, forced, matching the derivation above. **The vanishing of $c$ would be a coincidence, not a symmetry; the record measures $c\ne0$ ($\max\lvert T\rvert=0.395$), and $\det M$ takes both signs, which is exactly "$\theta$ signs both ways at cubic order".**

**This is the broken step, named.** The block writes *"a genuine local max ... confirmed by full Hessian diagonalization"*. At $n=6$ full Hessian diagonalization returns $\min\operatorname{spec}(\tfrac\theta2-L_W)\vert_{W^\perp}=-9.5\times10^{-16}$, i.e. **negative semidefinite with an 18-dimensional kernel**. That is the *necessary* second-order condition and nothing more. **The block reads a necessary condition as a sufficient one**, and at the one dimension in its range where the two come apart, the sufficient one fails.

### F4, the dimension range: both numbers are wrong, and at the same end

| location | range asserted |
| --- | --- |
| [findings/second-order.md:31](../findings/second-order.md) (the canonical block) | $n=6,\dots,12$ |
| [results.md:306](../results.md) (the results.md copy of the same block) | $n=6,\dots,12$ |
| [results.md:114](../results.md) (the summary line) | $n=6,\dots,16$ |
| [report/sections/09-status.tex:28](../report/sections/09-status.tex) | $n=6,\dots,16$ |

**The disagreement is real and it is internal to results.md**, whose line 114 and line 306 give different ranges for the same result, so the report is not the odd one out; it agrees with results.md's summary against results.md's own block.

**But the question of which upper endpoint is right is moot, and the lower endpoint is wrong in all four.** The correct statement is **every even $n\ge8$**, with no upper bound and no numerics, by F2. And the wider range's own gloss gives the game away: results.md:114 says *"with the spectrum now in closed form (five rational families in $n/2$)"*, at $p=q=k=n/2$, L27's ten summands collapse to exactly six values, $1$ on $\langle W\rangle$ and then

$$\tfrac12,\qquad \tfrac{k-2}{2(k-1)},\qquad \tfrac1{k-1},\qquad -\tfrac1{k-1},\qquad 0,$$

**five rational families in $n/2$.** That closed form *is* L27's, so the "$n\le16$" run is a sampling of a formula the record already proves, and neither $12$ nor $16$ has any standing as a boundary.

**No citation relies on the wider range.** results.md:114 and the tex line are the only two carrying $16$, and both are summary rows; nothing derives from $n=14$ or $n=16$ specifically.

### F5, the citations, and whether any takes L3 as proved

| citation | what it takes from L3 | safe? |
| --- | --- | --- |
| [findings/second-order.md:31](../findings/second-order.md) | the canonical block itself | **false at $n=6$** |
| [results.md:306](../results.md) | verbatim duplicate of the block, plus `**Proof:** second-order.md` | **false at $n=6$**, and the pointer says "Proof" where the target has none |
| [results.md:114](../results.md) | summary row, "Machine-verified ... $n=6,\dots,16$" | correctly labelled *machine-verified*, but the range is wrong at both ends |
| [results.md:88](../results.md) | *"Lemma L2's crossover and Observation L3's Hessian check are parity-free in its integer conclusion"* | **uses it as a general fact.** Already flagged for a different reason by [r506](REVIEW_r506.md) ($S^{n/2}\times S^{n/2}$ does not exist at odd $n$) and now doubly wrong: the Hessian check is not parity-free, it is *false* at its own smallest even member |
| [findings/nondegeneracy.md:82](../findings/nondegeneracy.md) (L26's motivation) | *"Observation L3's nondegeneracy claim at $S^p\times S^q$ rested on a scan"* | **safe**, cites L3 only to say its warrant was a scan, which is the premise for replacing it. This is the one citation that reads L3 correctly |
| [report/sections/09-status.tex:28](../report/sections/09-status.tex) | *"Verified, $n=6,\dots,16$; Hessian derivation awaiting audit"* | **contradicted by line 85 of the same file** |
| [reviews/REVIEW_r324.md](REVIEW_r324.md) §5.2 | "L3's hunt", answered analytically | a review, outside the record |

**Nothing cites L3 as *proved* in the L15 sense**, no Lemma rests on it, and the two loads it carries (results.md:88's parity remark, the tex status row) are both descriptive. **So the blast radius of the refutation is small.** That is the good news, and it is the only good news.

### F6, "off the diagonal locus" is never defined in the block, though the answer is favourable

$W^*=S^{n/2}\times S^{n/2}$ **is itself coordinate-diagonal**, [results.md](../results.md)'s Lemma L4 says so explicitly (*"which is exactly why $S^3\times S^3$ *is* diagonal"*). So the phrase cannot mean "$W^*$ lies off the locus"; it must mean *"local max against perturbations that leave the diagonal locus"*, i.e. a local max on the full unit sphere of $\mathcal W_n$ rather than within the diagonal slice. **The block never says this**, and a reader who takes the other reading gets a strictly weaker claim.

The distinction is resolved favourably by L27 at $n\ge8$: Nienhaus's ten summands exhaust $\mathrm{Weyl}_n$ (the block above notes *"the ten dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$"*) so the spectrum is over the whole space and the strong reading holds. **But that is L27's doing, not L3's.** L3's own warrant names neither the space nor the reading.

### F7, what the record can now prove, stated as the replacement

**Observation L3 should be deleted and replaced by a Lemma, whose proof is already on file in two pieces.**

> **Lemma (local maximality of the balanced sphere pair).** Let $n\ge8$ be even, $k=n/2$, and $W^*=W_{k,k}$ the balanced sphere-product critical point. Then $W^*$ is a local maximum of $P$ on the unit sphere of $\mathcal W_n$ (the *whole* space, not the diagonal slice), attained on the whole $O(n)$-orbit and strict transverse to it, with the transverse Hessian bounded above by $-\dfrac{6\theta_0(n)}{n-2}$.
>
> **Proof.** [Lemma L24](../findings/second-order.md): the geodesic Hessian of $P$ on the unit sphere at a critical point is $6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$. [Lemma L27](../findings/nondegeneracy.md): at $W_{p,q}$ with $p,q\ge3$, $(p,q)\ne(3,3)$, the ten Nienhaus summands are multiplicity-free, $L_e$ is a scalar on each, and $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ attained **exactly** on the $pq$-dimensional orbit tangent. At $p=q=k\ge4$ the remaining eigenvalues are $\tfrac{k-2}{2(k-1)},\ \pm\tfrac1{k-1},\ 0$, all at distance at least $\tfrac1{2(k-1)}=\tfrac1{n-2}$ below $\tfrac12$. So the Hessian vanishes on the orbit tangent, along which $P$ is constant by $O(n)$-invariance, and is $\le-6\theta/(n-2)$ on its orthogonal complement in $W^\perp$. Morse–Bott. $\square$
>
> **And the hypothesis $k\ge4$ is sharp**: at $k=3$ the point is a degenerate saddle, refuted at third order, [findings/second-order.md](../findings/second-order.md)'s higher-variation section and [findings/nondegeneracy.md:347](../findings/nondegeneracy.md).

**Three edits this implies.**

1. **[findings/second-order.md:31](../findings/second-order.md)**, the block loses its $n=6$ endpoint, its numerical warrant, and its `Observation` label; it gains the two-line proof above. The heading's promise of "canonical statement and proof" then becomes true.
2. **[results.md:88](../results.md)**, *"Observation L3's Hessian check are parity-free"* must go. It is not parity-free (no balanced product at odd $n$, already r506's point) and it is not a check that passes at $n=6$.
3. **[report/sections/09-status.tex:28](../report/sections/09-status.tex)**, the row must not say "Verified, $n=6,\dots,16$" while line 85 of the same file calls $n=6$ a degenerate saddle. The row should read *Proven, every even $n\ge8$; $n=6$ is a degenerate saddle.*

### F8, a smaller point, recorded so it is not lost

The whole of L3's second sentence, *"So $n\ge12$ is about which of two local maxima wins globally, not about $W^*$ losing local maximality"*, is the block's actual payload, and it **survives**, but for a different reason than the block gives. At $n\ge12$ it follows from the Lemma above with no numerics. At $n=6,8,10$ it is a statement about a régime where $W^*$ loses anyway (the padded $W_{\mathbb{CP}^2}$ sits at $\sqrt{3/2}>\theta_0(n)$ until $n=12$), so nothing turns on it; and at $n=6$ the premise it asserts is false.

---

## VERDICT: REFUTED

**The witness is $n=6$, the lower endpoint of L3's own stated range.** There $W^*=S^3\times S^3$ is a degenerate saddle, not a local maximum: the Hessian has nine null directions transverse to the orbit, and $P$ increases at cubic order along them. **The broken step is the inference from "full Hessian diagonalization" to "a genuine local max"**, at $n=6$ the diagonalization returns a negative *semi*definite Hessian, which is the necessary second-order condition and not the sufficient one, and the sufficient one fails at third order. The record already states this in [findings/second-order.md:121 and :171](../findings/second-order.md), [findings/nondegeneracy.md:347](../findings/nondegeneracy.md), and [report/sections/09-status.tex:85](../report/sections/09-status.tex), the last of these 57 lines below the status row that asserts L3.

**And the claim is simultaneously under-claimed where it is true.** At every even $n\ge8$ it is a **Lemma**, not an Observation: [Lemma L27](../findings/nondegeneracy.md) plus [Lemma L24](../findings/second-order.md) prove it symbolically in $n$, with a transverse Hessian gap of $6\theta/(n-2)$, over the whole of $\mathcal W_n$ and with no upper dimension bound. Its numerical warrant at $n=8,10,12$ is redundant; the dispute between $n\le12$ and $n\le16$ is moot.

**Blast radius: small.** No Lemma rests on L3. Its two live loads are [results.md:88](../results.md)'s parity remark (which fails independently) and the status row in the report, which its own file contradicts. [findings/nondegeneracy.md:82](../findings/nondegeneracy.md) cites L3 only to say its warrant was a scan, and is correct.

*Analysis-only footing observed: nothing was run. The one point I could not settle by hand is the value of the constant $c$ in $P\vert_{\text{excess}}=c\det M$ at $(3,3)$, where symmetry permits $c\ne0$ but does not compute it; a single evaluation of $T(z,z,z)$ on one basis vector of $\Lambda^2\mathbb R^3\otimes\Lambda^2\mathbb R^3$ would decide it, and the record already reports $\max\lvert T\rvert=0.395$ from two independent reviewers. The refutation does not depend on my re-running it.*
