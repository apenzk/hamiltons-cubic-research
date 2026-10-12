# Review r523, Lemma L43

**Target.** Lemma L43, "the criterion at $a=0$ demands exactly $\theta_0(n)$", `findings/problem.md`, `#### Lemma L43` (line 472) down to the next heading.

**Statement under audit.** On the slice $R_{\mathrm{ric}_0}=0$ the Böhm–Wilking cone-invariance criterion at $a=0$ collapses with no residue to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$ with $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

**Footing.** Analysis only. No searches, sweeps, censuses or falsifier hunts. Screening of a claim about to be recorded is permitted and is labelled as a screen.

## Phase plan

0. Log + report skeleton.
1. Fix conventions against the record's anchors.
2. Read the L43 block verbatim.
3. Chase the pointer to the named section.
4. Derive the collapse at $a=0$ on the slice.
5. Trace the provenance of $\theta_0(n)$ for circularity.
6. Slice semantics and attainment.
7. "Exactly": sufficiency and necessity.
8. The 7 citations.
9. Contradictions elsewhere in `findings/`.
10. Verdict.

## Findings

### 1. The pointer resolves, unlike L46 and L57

The block's pointer reads *"the argument is in this file under **The diagonal case: located in the literature, and it covers less than **"*, breaking off mid-phrase. The real heading is [problem.md:13](../findings/problem.md#L13), *"### The diagonal case: located in the literature, and it covers less than assumed"*, the pointer is the true title truncated after "less than ", not a false title.

**And that section does hold the argument.** It is at [problem.md:48–64](../findings/problem.md#L48), under the bold sub-heading *"$\theta_0(n)$ IS DERIVED, NOT POSITED, the criterion at $a=0$ produces the target constant exactly."* This is the failure mode that killed the pointers of [L46](../findings/problem.md#L483) and [L57](../findings/problem.md#L511), and L43 does not repeat it. **The one presentational defect is real but minor**: a section headed "the diagonal case" is the last place a reader looks for a cone-invariance derivation, and the pointer's truncation makes the title unsearchable as quoted.

**A second, harder pointer defect.** The block's statement line reads *"the invariance criterion \eqref{eq:criterion} at $a=0$"*. The label `eq:criterion` is defined **only** in [report/sections/05-landscape.tex:42](../report/sections/05-landscape.tex#L42) and exists nowhere in [findings/](../findings/). The block was lifted from the report and the cross-reference came with it, so inside `findings/` it resolves to nothing: the criterion the lemma is about is never displayed in the file that holds the lemma.

### 2. The collapse, derived cold, and it is genuinely residue-free

I rebuilt it from the definitions without using the block's arithmetic.

**Setup.** [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) attaches $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ and $\Omega_a=F^{-1}\big((-\infty,\tfrac4{n-2+4a}]\big)$. With $A=\lVert R\rVert^2$, $B=\lVert\mathrm{ric} R\rVert^2$ and $\mathrm{ric}$ linear, $dF_R(S)=\tfrac2B\big(\langle R,S\rangle-F(R)\langle\mathrm{ric} R,\mathrm{ric} S\rangle\big)$, so with $S=\Phi(R)$ and $B>0$,

$$G(R)\le0\iff\langle R,\Phi(R)\rangle\le F(R)\,\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle.$$

That reproduces the criterion. I also checked the cone family against itself: $F\le\tfrac4{n-2+4a}$ expands, using the stated $\lVert\mathrm{ric} R\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$, to exactly Beitz's p. 96 form $\tfrac{4a-n}4\lVert R_I\rVert^2+a\lVert R_{\mathrm{ric}_0}\rVert^2+(\tfrac{n-2}4+a)\lVert R_W\rVert^2\le0$, and $F(I)=\tfrac{2}{n-1}=\tfrac4{n-2+4a}\big|_{a=n/4}$. The normalisation is pinned two independent ways.

**Left side.** $\Phi(cI+W)=c^2\Phi(I)+2c\Phi(I,W)+Q(W)$. From [BW08 Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md), $I\#I=(n-2)I$ so $\Phi(I)=(n-1)I$ (which is the record's anchor $\mathrm{Id}^\#=(n-2)\mathrm{Id}$) and $W\#I=-W$ so $\Phi(I,W)=\tfrac12(IW+WI)+W\#I=W-W=0$. Then $\langle W,I\rangle=\operatorname{tr}W=0$ and $\operatorname{tr}Q(W)=0$, giving $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle$.

**Right side.** On the slice $\mathrm{ric}(R)=c\,\mathrm{ric}(I)$, and [BW08 eq. (6)](../references/boehm-wilking-2008-space-forms/notes.md) gives $\mathrm{ric}(Q(W))=0$, so $\mathrm{ric}(\Phi(R))=c^2(n-1)\mathrm{ric}(I)$ and

$$F(R)\langle\mathrm{ric} R,\mathrm{ric}\Phi(R)\rangle=\frac{c^2\lVert I\rVert^2+\lVert W\rVert^2}{c^2\lVert\mathrm{ric} I\rVert^2}\cdot c^3(n-1)\lVert\mathrm{ric} I\rVert^2=c(n-1)\big(c^2\lVert I\rVert^2+\lVert W\rVert^2\big).$$

$\lVert\mathrm{ric}(I)\rVert^2$ cancels, and **the $c^3(n-1)\lVert I\rVert^2$ term is identical on both sides and cancels too**. The residue is exactly $\langle W,Q(W)\rangle-c(n-1)\lVert W\rVert^2$ and nothing else.

**Stronger than the block claims.** That cancellation used only $R=cI+W$, *not* the boundary equation. So the collapse is an identity on the whole slice for every $c>0$, and $\partial\Omega_0$ enters only to fix $c$. Screened symbolically in sympy over general $(n,c,\lVert W\rVert,P)$: residue $=P-c(n-1)\lVert W\rVert^2$, exactly.

**"With no residue" is TRUE.** No unstated extra hypothesis is doing work; the two cubic terms that could have survived are killed by identities, not by a coincidence.

### 3. The constant, no import, no circularity

Imposing $\partial\Omega_0$, $\tfrac{n-2}n\lVert W\rVert^2=\lVert R_I\rVert^2=c^2\lVert I\rVert^2$ with $\lVert I\rVert^2=\binom n2$ gives $c=\tfrac{\lVert W\rVert}n\sqrt{\tfrac{2(n-2)}{n-1}}$ and

$$c(n-1)\lVert W\rVert^2=\frac{\sqrt{2(n-1)(n-2)}}n\lVert W\rVert^3=\theta_0(n)\lVert W\rVert^3 .$$

Verified exactly (sympy, symbolic $n$; the difference simplifies to $0$ at $n=4,6,8,11,12,13,16$), and $\theta_0(6)=\sqrt{10}/3$ matches the record's anchor.

**The complete input list is:** $\lVert I\rVert^2=\binom n2$ (a dimension count); $I\#I=(n-2)I$ and $W\#I=-W$ (BW08 Lemma 2.1, one $O(n)$-equivariance argument); $\mathrm{ric}(Q(W))=0$ for Weyl $W$ (BW08 eq. 6); the cone coefficient $\tfrac{n-2}4$ at $a=0$ and the Ricci-norm coefficient $\tfrac{n-1}2$ (Beitz p. 96). **Not one of these is a sphere-product computation, a value of $\Theta_n$, or a result resting on either.** $\theta_0(n)$ is assembled here out of $\tfrac{n-2}4$, $\tfrac{n-1}2$ and $\binom n2$. The lemma's headline force (the constant is fixed from outside the sphere products), **holds**.

The certificate in [05-landscape.tex](../report/sections/05-landscape.tex#L64) cites a second reviewer who recomputed $\theta_{p,q}$ on sphere products. That is corroboration downstream of the derivation, not an input to it; the L2-style "three derivations sharing one point of failure" pattern does not apply, because this route has *no* sphere product in it at all.

### 4. The slice, Einstein, not Ricci-flat, and $a=0$ is attained

$R_{\mathrm{ric}_0}=0$ kills the **traceless-Ricci block** of $R$, leaving $R=cI+W$: algebraically Einstein, with $\mathrm{ric}(R)=c\,\mathrm{ric}(I)\ne0$. It is **not** Ricci-flatness. This distinction is load-bearing: Ricci-flat would force $c=0$, hence $\mathrm{ric}(R)=0$, hence $F=\infty$, putting $R$ outside every $\Omega_a$ and making the criterion vacuous. The record keeps the two apart correctly everywhere I checked, $W$ itself is Ricci-flat, $R$ is not.

**The end is attained, not approached.** Beitz's Remark 6.3.15 conjectures invariance for $a\in[0,\tfrac n4]$, a **closed** interval, and $\Omega_0=F^{-1}((-\infty,\tfrac4{n-2}])$ is perfectly well defined. The table row at [problem.md:44](../findings/problem.md#L44) writes the end as "$a\to0$" and [05-landscape.tex](../report/sections/05-landscape.tex#L38) as "as $a\to0$ it opens to", loose phrasing for a member of the family, harmless but worth tightening.

**The slice points are genuine boundary points.** For every Weyl $W$, the pair $(c,W)$ with $c$ as above gives $R=cI+W\in\partial\Omega_0$ with $\mathrm{scal}(R)>0$. So the collapse yields the inequality for *every* Weyl $W$, it really is Conjecture A's inequality, not a sub-family of it.

### 5. GAP, $\partial\Omega_0$ fixes $c^2$, and the block picks the root silently

The boundary equation $\tfrac{n-2}n\lVert W\rVert^2=c^2\lVert I\rVert^2$ determines $c^2$, giving $c=\pm\tfrac1n\sqrt{2(n-2)/(n-1)}$ at $\lVert W\rVert=1$. [problem.md:60](../findings/problem.md#L60) and the report's proof both write "gives $c=\tfrac1n\sqrt{2(n-2)/(n-1)}$" with no word about the sign.

**This is load-bearing.** Under $c<0$ the same residue-free collapse reads $\langle W,Q(W)\rangle\le-\theta_0(n)\lVert W\rVert^3$, which is false at $W=W_{S^{n/2}\times S^{n/2}}$, so $\Omega_0$ would be non-invariant at every $n$ and the cone conjecture vacuous.

**The fact that licenses the positive root is on the record, one file away, and is never cited at the step.** Beitz's actual definition, quoted in [references/beitz-2018-bianchi-convexity/notes.md](../references/beitz-2018-bianchi-convexity/notes.md), is
$$\Omega_a:=\Big\{R\in\mathcal A_n\ \Big|\ \big(\tfrac{n-2}4+a\big)\lVert R\rVert^2\le\lVert\mathrm{ric}(R)\rVert^2\ \textbf{ and }\ \mathrm{scal}(R)>0\Big\},$$
and $\mathrm{scal}(cI+W)>0\iff c>0$. [problem.md](../findings/problem.md) reproduces only the $R\mapsto-R$-symmetric decomposition inequality and drops the `scal > 0` clause; its table row "$\Omega_{n/4}=\mathbb R_{>0}\cdot I$, **a single ray**" encodes the positivity implicitly and is the only trace of it in the file.

**Verdict on this point: a gap in exposition, not in truth.** One clause repairs it.

### 6. "Exactly", both halves hold

The collapse is an **equivalence** at each slice boundary point, so:

- **$\theta_0(n)$ suffices** for the criterion there: $P(W)\le\theta_0\lVert W\rVert^3$ makes $G(R)\le0$ at every such $R$.
- **Nothing smaller is demanded and nothing larger will do**: the right-hand side is $c(n-1)\lVert W\rVert^2$ with no slack. Any $\theta'<\theta_0$ would be strictly stronger than invariance requires; any $\theta'>\theta_0$ strictly weaker.

The direction the lemma actually needs (*invariance $\Rightarrow G\le0$*), is immediate and not merely asserted: if $G(R_0)>0$ at $R_0\in\partial\Omega_0$ then $F(R(t))>F(R_0)=\tfrac4{n-2}$ for small $t>0$, so $R(t)\notin\Omega_0$. [Beitz Lemma 2.3.4](../references/beitz-2018-bianchi-convexity/notes.md) supplies only the converse, and the block names this as an owed input, correctly.

**Two claimed inputs are not actually needed, and the block knows it.** Bianchi-preservation by $\Phi$ is invoked at [05-landscape.tex:58](../report/sections/05-landscape.tex#L58) to justify "$\Phi(W)$ is again Weyl"; but $\langle I,Q(W)\rangle=\operatorname{tr}Q(W)$ needs only tracelessness, and Beitz's $\mathrm{scal}(R^2+R^\#)=2\lVert\mathrm{ric}(R)\rVert^2$ gives that in one line. Likewise the total symmetry of $T$. The proof's own closing sentence (*"the collapse needs only bilinearity, $\Phi(I,W)=0$ and $\mathrm{scal}(Q(W))=0$"*), is the accurate account, and it sits in mild tension with the Bianchi remark three sentences earlier.

**Sharpness is a separate statement and is scoped correctly.** $\theta_0(n)$ is *attained* only at even $n$; [problem.md:73](../findings/problem.md#L73) says so. The lemma claims the constant is demanded, not that it is achieved, and does not overreach.

### 7. The citations

| where | what it takes | verdict |
| --- | --- | --- |
| [results.md:37](../results.md#L37) | the constant and its exactness, "demands $\theta_0(n)$ and nothing weaker" | **sound** |
| [results.md:46](../results.md#L46) | the collapse (but writes it as $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^{\mathbf 2}$ | **defect**), see below |
| [results.md:282](../results.md#L282) (L44) | the collapse, evaluated at padded $W_{\mathbb{CP}^2}$ on $\partial\Omega_0$ | **sound**, that point is on the slice, and the necessity direction is the one L43 supplies |
| [results.md:764](../results.md#L764) (L0) | "$P$ and Conjecture A are the same statement, **through the cone bridge of Lemma L43**" | **defect**, over-read; see below |
| [00-abstract.tex:11](../report/sections/00-abstract.tex#L11) | "whose open end demands exactly $\theta_0(n)$", the slice unmentioned | acceptable, the whole-boundary criterion implies the slice one, so the necessity claim survives the compression |
| [01-introduction.tex:50](../report/sections/01-introduction.tex#L50) | "Demanded by cone invariance at $a=0$, independently of the sphere products" | **sound** |
| [05-landscape.tex:75](../report/sections/05-landscape.tex#L75) | "Lemma 43 is sharp at $a=0$", via the L44 witness | **sound** |
| [09-status.tex:67](../report/sections/09-status.tex#L67) | status **"Proven"** | **defect**, status inflation; see below |

**Defect A, a degree error at [results.md:46](../results.md#L46).** It reads *"collapses to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^2$ with $\theta_0(n)=c(n-1)$"*. The left side is $3$-homogeneous and the right is $2$-homogeneous, so the statement is false for every $\lVert W\rVert\ne1$. It has merged the block's two displays: the intermediate form $\le c(n-1)\lVert W\rVert^2$ (correct, $c$ scaling with $\lVert W\rVert$) and the final $\le\theta_0(n)\lVert W\rVert^3$. [results.md:100](../results.md#L100) states the intermediate form and is correct; the lemma block itself is correct. **Fix: $\lVert W\rVert^2\to\lVert W\rVert^3$ at [results.md:46](../results.md#L46).**

**Defect B, [results.md:764](../results.md#L764) over-reads L43.** Lemma L0's own block, [problem.md:453–470](../findings/problem.md#L453), is a compactness equivalence, $\sup P=\theta_0(n)$ iff $P\le\theta_0(n)$ at every critical point, with no cone, no $\Omega_a$ and no L43 in its proof. The "Audit owed" gloss attributes it to "the cone bridge of Lemma L43" and, read as *cone invariance $\equiv$ Conjecture A*, is contradicted by two passages the record already holds: [problem.md:94](../findings/problem.md#L94), *"What is settled is that the target constant is right, **not that the two statements coincide**"*, and the [Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md), *"**They are not the same statement**, the cone conjecture leaves $R_{\mathrm{ric}_0}$ unconstrained at $a=0$ and is strictly stronger."* L43 is scoped to the slice and does not license the equivalence. **The mis-citation is L0's, not L43's**, L43's own scope paragraph is exemplary.

**Defect C, status.** [09-status.tex:67](../report/sections/09-status.tex#L67) records L43 as **"Proven"**, while [findings/INDEX-results.md:58](../findings/INDEX-results.md#L58) carries *"Gate 2: no verdict on the record"* and [plan-verification.md:72](../plan-verification.md#L72) leaves it unchecked. The mathematics is right, so the row is not *wrong* about the world, but it is ahead of the record's own gate, and the record's convention is that "Lemma" means both gates passed.

### 8. Nothing below the block contradicts it

- [problem.md](../findings/problem.md)'s later sections are consistent throughout. The off-slice expansion at [:76–94](../findings/problem.md#L76) *bounds* L43 rather than contradicting it, and setting $Y=0$ recovers the collapse exactly, the file runs its own consistency check.
- **[Post F36](../findings/fence-posts.md#L285) is a false alarm.** It reads *"cone invariance (vacuous, $\mathbb R_+W^\ast$ satisfies it)"*, which looks like a refutation of L43's whole framing. It is a **different cone question** ($Q$-invariant cones inside $\mathrm{Weyl}_n$ under $\dot W=Q(W)$) and the post itself says so in its last sentence: *"Beitz's $\Omega_a$ cones are already priced as strictly stronger than Conjecture A."* No clash.
- [findings/target.md:688–693](../findings/target.md#L688) restates the off-slice expansion in the same terms. Consistent.
- [INDEX-traps.md](../findings/INDEX-traps.md) holds nothing bearing on the collapse.

## Verdict

**The statement is true, the collapse is genuinely residue-free, and $\theta_0(n)$ is derived without any sphere product.** I rebuilt every step from the definitions and reached the same constant; the three literature inputs are correctly quoted against [BW08](../references/boehm-wilking-2008-space-forms/notes.md) and [Beitz](../references/beitz-2018-bianchi-convexity/notes.md), the anchors $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, $\operatorname{tr}W^\#=-1$ and $\theta_0(6)=\sqrt{10}/3$ all check, and the collapse turns out to be an identity on the whole slice rather than only on $\partial\Omega_0$.

Four defects, none of which touches the truth of the lemma:

1. **`\eqref{eq:criterion}` at [problem.md:476](../findings/problem.md#L476) is dangling**, the label lives only in [05-landscape.tex](../report/sections/05-landscape.tex#L42), so inside `findings/` the lemma names a criterion the file never displays.
2. **The pointer's quoted title is truncated** at "less than " and the section it names ("The diagonal case…") gives no hint that a cone derivation is inside it. The section *does* hold the argument.
3. **The positive root of $c$ is taken silently.** Repaired by quoting Beitz's `scal(R) > 0` clause, which [findings/problem.md](../findings/problem.md) drops from her definition of $\Omega_a$.
4. **Two citations misfire**: [results.md:46](../results.md#L46) writes $\lVert W\rVert^2$ for $\lVert W\rVert^3$, and [results.md:764](../results.md#L764) attributes Lemma L0 to "the cone bridge of Lemma L43", an equivalence L43 explicitly declines to assert and that two other places in the record deny. [09-status.tex:67](../report/sections/09-status.tex#L67) also calls L43 "Proven" against the index's "no verdict".

*Screening note: the only computation run was a seconds-long sympy simplification of the algebra above, on expressions I constructed to check a claim I was about to record. No search, sweep or census was run.*

VERDICT: CONFIRMED
